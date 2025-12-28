# 🏗️ Flutter Clean Architecture Guide

This comprehensive guide explains the Clean Architecture implementation in our Flutter project, covering principles, patterns, and practical examples for developers of all levels.

## 📋 Table of Contents

- [🎯 What is Clean Architecture?](#-what-is-clean-architecture)
- [🏛️ Architecture Layers](#️-architecture-layers)
- [📐 SOLID Principles](#-solid-principles)
- [🔄 Data Flow](#-data-flow)
- [📁 Project Structure](#-project-structure)
- [🛠️ Implementation Details](#️-implementation-details)
- [📊 Practical Examples](#-practical-examples)
- [🧪 Testing Strategy](#-testing-strategy)
- [✅ Best Practices](#-best-practices)
- [❌ Common Pitfalls](#-common-pitfalls)
- [🚀 Benefits](#-benefits)

## 🎯 What is Clean Architecture?

Clean Architecture is a software design philosophy created by Robert C. Martin (Uncle Bob) that emphasizes separation of concerns and dependency inversion. It creates systems that are:

- **Independent of Frameworks**: The architecture doesn't depend on external libraries
- **Testable**: Business rules can be tested without UI, database, or external elements
- **Independent of UI**: The UI can change without changing the business rules
- **Independent of Database**: Business rules are not bound to the database
- **Independent of External Agency**: Business rules don't know anything about the outside world

### Core Philosophy

```
"The center of your application is not the database. Nor is it one or more of the frameworks you may be using. The center of your application is the use cases of your application."
- Robert C. Martin
```

## 🏛️ Architecture Layers

Our Flutter Clean Architecture consists of three main layers, each with specific responsibilities and dependencies flowing inward:

```
┌─────────────────────────────────────────────────────────┐
│                 🎨 PRESENTATION LAYER                    │
│                                                         │
│  • UI Components (Screens, Widgets)                    │
│  • State Management (BLoC/Cubit)                       │
│  • Routes & Navigation                                  │
│  • User Input Handling                                 │
│                                                         │
│  Dependencies: Domain Layer                             │
└─────────────────────┬───────────────────────────────────┘
                      │ Depends on
                      ▼
┌─────────────────────────────────────────────────────────┐
│                 🎯 DOMAIN LAYER                         │
│                                                         │
│  • Business Logic (Use Cases)                          │
│  • Entities & Value Objects                            │
│  • Repository Interfaces                               │
│  • Core Abstractions                                   │
│                                                         │
│  Dependencies: None (Pure Dart)                        │
└─────────────────────▲───────────────────────────────────┘
                      │ Implements
                      │
┌─────────────────────────────────────────────────────────┐
│                 💾 DATA LAYER                           │
│                                                         │
│  • Repository Implementations                           │
│  • Data Sources (Remote API, Local Storage)            │
│  • Models & Mappers                                     │
│  • External Service Integrations                       │
│                                                         │
│  Dependencies: Domain Layer                             │
└─────────────────────────────────────────────────────────┘
```

### 🎨 Presentation Layer

**Responsibility**: Handle user interface and user interactions

**Components**:
- **Screens/Pages**: UI layouts and visual components
- **BLoC/Cubit**: State management and UI logic coordination
- **Routes**: Navigation configuration
- **Widgets**: Reusable UI components
- **Theme**: Visual styling and theming

**Key Characteristics**:
- Depends only on Domain layer
- Contains no business logic
- Handles user input and displays data
- Manages UI state

**Example Structure**:
```dart
// Screen
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(getIt<LoginUserUsecase>()),
      child: LoginView(),
    );
  }
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _loginUsecase;
  
  LoginBloc(this._loginUsecase) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }
}
```

### 🎯 Domain Layer

**Responsibility**: Contains business logic and rules (Pure Dart)

**Components**:
- **Entities**: Core business objects
- **Use Cases**: Business operations and workflows
- **Repository Interfaces**: Data access contracts
- **Value Objects**: Domain-specific data types
- **Core**: Domain-level utilities and abstractions

**Key Characteristics**:
- No dependencies on external frameworks
- Contains pure business logic
- Defines contracts for data access
- Framework-agnostic

**Example Structure**:
```dart
// Entity
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  
  const User({required this.id, required this.name, required this.email});
  
  @override
  List<Object> get props => [id, name, email];
}

// Use Case
class LoginUserUsecase extends UsecaseAsync<User, LoginCredentials> {
  final IAuthRepository _repository;
  
  LoginUserUsecase(this._repository);
  
  @override
  ResultFuture<User> call(LoginCredentials params) {
    return _repository.login(params);
  }
}

// Repository Interface
abstract class IAuthRepository {
  ResultFuture<User> login(LoginCredentials credentials);
  ResultFuture<void> logout();
}
```

### 💾 Data Layer

**Responsibility**: Handle data access and external services

**Components**:
- **Repository Implementations**: Implement domain repository interfaces
- **Data Sources**: Handle external data (API, Database, Storage)
- **Models**: Data transfer objects with serialization
- **Mappers**: Convert between models and entities
- **Core**: Data layer utilities and error handling

**Key Characteristics**:
- Implements domain contracts
- Handles external dependencies
- Manages data transformation
- Contains no business logic

**Example Structure**:
```dart
// Repository Implementation
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final ApiService _apiService;
  final ILocalStorage _localStorage;
  
  AuthRepositoryImpl(this._apiService, this._localStorage);
  
  @override
  ResultFuture<User> login(LoginCredentials credentials) {
    return guardDio(() async {
      final dto = await _apiService.login(credentials.toRequest());
      await _localStorage.saveToken(dto.token);
      return dto.toEntity();
    });
  }
}

// Data Source
@RestApi()
abstract class ApiService {
  @POST('/auth/login')
  Future<LoginDto> login(@Body() LoginRequest request);
}
```

## 📐 SOLID Principles

Clean Architecture is built on SOLID principles. Here's how they apply to our Flutter project:

### S - Single Responsibility Principle

**"A class should have one, and only one, reason to change."**

**Examples**:
```dart
// ✅ Good - Single responsibility
class LoginUserUsecase {
  // Only responsible for login business logic
  ResultFuture<User> call(LoginCredentials credentials) { ... }
}

class LoginBloc {
  // Only responsible for login UI state management
  void add(LoginEvent event) { ... }
}

class ApiService {
  // Only responsible for API communication
  Future<LoginDto> login(LoginRequest request) { ... }
}

// ❌ Bad - Multiple responsibilities
class LoginManager {
  // Violates SRP - handles UI, business logic, and API calls
  void showLoginForm() { ... }
  User validateCredentials() { ... }
  Future<LoginDto> callLoginApi() { ... }
}
```

### O - Open/Closed Principle

**"Software entities should be open for extension, but closed for modification."**

**Examples**:
```dart
// ✅ Good - Open for extension via interfaces
abstract class IAuthRepository {
  ResultFuture<User> login(LoginCredentials credentials);
}

class ApiAuthRepository implements IAuthRepository { ... }
class MockAuthRepository implements IAuthRepository { ... }
class CachedAuthRepository implements IAuthRepository { ... }

// ✅ Good - Extending functionality without modifying existing code
abstract class AppLogger {
  void log(String message);
}

class ConsoleLogger implements AppLogger { ... }
class FileLogger implements AppLogger { ... }
class RemoteLogger implements AppLogger { ... }
```

### L - Liskov Substitution Principle

**"Objects of a superclass should be replaceable with objects of its subclasses."**

**Examples**:
```dart
// ✅ Good - Substitutable implementations
abstract class ILocalStorage {
  ResultFuture<String?> getString(String key);
}

class SharedPreferencesStorage implements ILocalStorage {
  @override
  ResultFuture<String?> getString(String key) {
    // Implementation using SharedPreferences
  }
}

class SecureStorage implements ILocalStorage {
  @override
  ResultFuture<String?> getString(String key) {
    // Implementation using FlutterSecureStorage
  }
}

// Both can be used interchangeably
ILocalStorage storage = SharedPreferencesStorage(); // or SecureStorage()
final result = await storage.getString('key');
```

### I - Interface Segregation Principle

**"Many client-specific interfaces are better than one general-purpose interface."**

**Examples**:
```dart
// ✅ Good - Segregated interfaces
abstract class IUserReader {
  ResultFuture<User> getUser(String id);
}

abstract class IUserWriter {
  ResultFuture<void> saveUser(User user);
}

abstract class IUserDeleter {
  ResultFuture<void> deleteUser(String id);
}

// Clients depend only on what they need
class UserProfileUsecase {
  final IUserReader _userReader;
  UserProfileUsecase(this._userReader); // Only needs reading
}

class SaveUserUsecase {
  final IUserWriter _userWriter;
  SaveUserUsecase(this._userWriter); // Only needs writing
}

// ❌ Bad - Fat interface
abstract class IUserRepository {
  ResultFuture<User> getUser(String id);
  ResultFuture<void> saveUser(User user);
  ResultFuture<void> deleteUser(String id);
  ResultFuture<List<User>> getAllUsers();
  ResultFuture<void> exportUsers();
  ResultFuture<void> importUsers();
  // ... many more methods
}
```

### D - Dependency Inversion Principle

**"Depend on abstractions, not concretions."**

**Examples**:
```dart
// ✅ Good - Depends on abstraction
class LoginBloc {
  final LoginUserUsecase _loginUsecase; // Abstraction
  
  LoginBloc(this._loginUsecase);
}

class LoginUserUsecase {
  final IAuthRepository _repository; // Abstraction
  
  LoginUserUsecase(this._repository);
}

// ❌ Bad - Depends on concretion
class LoginBloc {
  final ApiService _apiService; // Concretion
  final SharedPreferences _prefs; // Concretion
  
  LoginBloc(this._apiService, this._prefs);
}
```

## 🔄 Data Flow

Understanding data flow is crucial for Clean Architecture. Here's how data moves through our layers:

### Inward Data Flow (User Input)

```
User Input → Presentation → Domain → Data → External Services
```

**Example: User Login Flow**

1. **User Action**: User taps login button
2. **Presentation Layer**: BLoC receives login event
3. **Domain Layer**: Use case executes business logic
4. **Data Layer**: Repository calls API service
5. **External Service**: API validates credentials
6. **Return Path**: Data flows back through layers

```dart
// 1. User taps login button
onPressed: () => context.read<LoginBloc>().add(LoginRequested(username, password))

// 2. BLoC handles event
Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
  emit(LoginLoading());
  
  // 3. Call use case
  final result = await _loginUsecase(LoginCredentials(
    username: event.username,
    password: event.password,
  ));
  
  // 6. Handle result
  result.fold(
    (failure) => emit(LoginError(failure.message)),
    (user) => emit(LoginSuccess(user)),
  );
}

// 4. Use case executes
@override
ResultFuture<User> call(LoginCredentials params) {
  return _repository.login(params); // 5. Repository handles data access
}
```

### Outward Data Flow (Data Updates)

```
External Services → Data → Domain → Presentation → UI Update
```

**Example: Real-time Data Update**

1. **External Event**: Server sends push notification
2. **Data Layer**: Repository receives and processes data
3. **Domain Layer**: Use case validates and transforms data
4. **Presentation Layer**: BLoC updates state
5. **UI Update**: Widgets rebuild with new data

## 📁 Project Structure

Our Clean Architecture is reflected in the project structure:

```
lib/
├── 🎯 domain/                    # Business Logic Layer
│   ├── core/                    # Domain abstractions
│   │   ├── app_logger.dart      # Logger interface
│   │   ├── failures.dart        # Error types
│   │   ├── result.dart          # Result type definitions
│   │   └── usecase.dart         # Use case base classes
│   ├── entities/                # Business entities
│   │   ├── user.dart
│   │   └── product.dart
│   ├── repositories/            # Repository interfaces
│   │   ├── auth_repository.dart
│   │   └── product_repository.dart
│   ├── usecase/                 # Business use cases
│   │   ├── login_user_usecase.dart
│   │   └── get_products_usecase.dart
│   └── value_object/            # Domain value objects
│       └── login_credentials.dart
│
├── 💾 data/                      # Data Access Layer
│   ├── core/                    # Data utilities
│   │   ├── guard.dart           # Error handling
│   │   ├── interceptors.dart    # HTTP interceptors
│   │   └── exceptions.dart      # Custom exceptions
│   ├── datasources/             # Data source implementations
│   │   ├── local/              # Local storage
│   │   │   ├── local_storage_datasource.dart
│   │   │   └── local_storage_datasource_impl.dart
│   │   └── remote/             # Remote API
│   │       ├── api_service.dart
│   │       └── api_service.g.dart
│   ├── models/                  # Data transfer objects
│   │   ├── request/
│   │   │   └── login_request.dart
│   │   └── response/
│   │       └── login_dto.dart
│   ├── mappers/                 # Data transformation
│   │   └── login_mapper.dart
│   └── repositories/            # Repository implementations
│       ├── auth_repository_impl.dart
│       └── product_repository_impl.dart
│
├── 🎨 presentation/              # UI Layer
│   ├── bloc/                    # State management
│   │   ├── login/
│   │   │   ├── login_bloc.dart
│   │   │   ├── login_event.dart
│   │   │   └── login_state.dart
│   │   └── products/
│   ├── screens/                 # UI screens
│   │   ├── login/
│   │   │   └── login_screen.dart
│   │   └── products/
│   ├── shared/                  # Reusable components
│   │   ├── widgets/
│   │   └── components/
│   └── routes/                  # Navigation
│       └── app_router.dart
│
└── 💉 di/                        # Dependency Injection
    ├── injector.dart            # DI configuration
    ├── injector.config.dart     # Generated DI code
    ├── domain_module.dart       # Domain dependencies
    ├── env_module.dart          # Environment config
    └── third_party_module.dart  # External dependencies
```

## 🛠️ Implementation Details

### Dependency Injection

We use GetIt with Injectable for dependency injection:

```dart
// 1. Define interfaces in domain layer
abstract class IAuthRepository {
  ResultFuture<User> login(LoginCredentials credentials);
}

// 2. Implement in data layer
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final ApiService _apiService;
  
  AuthRepositoryImpl(this._apiService);
  
  @override
  ResultFuture<User> login(LoginCredentials credentials) {
    // Implementation
  }
}

// 3. Register use cases in domain module
@module
abstract class DomainModule {
  @Injectable()
  LoginUserUsecase loginUserUsecase(IAuthRepository repository) {
    return LoginUserUsecase(repository);
  }
}

// 4. Use in presentation layer
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final loginUsecase = getIt<LoginUserUsecase>();
    // Use the use case
  }
}
```

### Error Handling

We use the Either pattern from dartz for error handling:

```dart
// Result type definitions
typedef ResultEither<T> = Either<Failures, T>;
typedef ResultFuture<T> = Future<ResultEither<T>>;

// Failure types
abstract class Failures {
  final Object? cause;
  final StackTrace? stackTrace;
  Failures({this.cause, this.stackTrace});
}

class NetworkFailure extends Failures { ... }
class ServerFailure extends Failures { ... }
class CacheFailure extends Failures { ... }

// Usage in repository
@override
ResultFuture<User> login(LoginCredentials credentials) {
  return guardDio(() async {
    final dto = await _apiService.login(credentials.toRequest());
    return dto.toEntity();
  });
}

// Usage in BLoC
final result = await _loginUsecase(credentials);
result.fold(
  (failure) => emit(LoginError(_mapFailureToMessage(failure))),
  (user) => emit(LoginSuccess(user)),
);
```

### State Management with BLoC

```dart
// Events
abstract class LoginEvent extends Equatable {}

class LoginRequested extends LoginEvent {
  final String username;
  final String password;
  
  LoginRequested(this.username, this.password);
  
  @override
  List<Object> get props => [username, password];
}

// States (using Freezed for immutability)
@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(User user) = _Success;
  const factory LoginState.error(String message) = _Error;
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _loginUsecase;
  
  LoginBloc(this._loginUsecase) : super(const LoginState.initial()) {
    on<LoginRequested>(_onLoginRequested);
  }
  
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.loading());
    
    final result = await _loginUsecase(LoginCredentials(
      username: event.username,
      password: event.password,
    ));
    
    result.fold(
      (failure) => emit(LoginState.error(failure.message)),
      (user) => emit(LoginState.success(user)),
    );
  }
}
```

## 📊 Practical Examples

### Complete Feature Implementation

Let's implement a complete "Get Products" feature following Clean Architecture:

#### 1. Domain Layer

**Entity**:
```dart
// domain/entities/product.dart
class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
  
  @override
  List<Object> get props => [id, name, description, price, imageUrl];
}
```

**Repository Interface**:
```dart
// domain/repositories/product_repository.dart
abstract class IProductRepository {
  ResultFuture<List<Product>> getProducts({String? category});
  ResultFuture<Product> getProductById(String id);
}
```

**Use Case**:
```dart
// domain/usecase/get_products_usecase.dart
class GetProductsUsecase extends UsecaseAsync<List<Product>, GetProductsParams> {
  final IProductRepository _repository;
  
  GetProductsUsecase(this._repository);
  
  @override
  ResultFuture<List<Product>> call(GetProductsParams params) {
    return _repository.getProducts(category: params.category);
  }
}

class GetProductsParams extends Equatable {
  final String? category;
  
  const GetProductsParams({this.category});
  
  @override
  List<Object?> get props => [category];
}
```

#### 2. Data Layer

**Model**:
```dart
// data/models/response/product_dto.dart
@JsonSerializable()
class ProductDto {
  final String id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  
  ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });
  
  factory ProductDto.fromJson(Map<String, dynamic> json) => 
      _$ProductDtoFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
```

**Mapper**:
```dart
// data/mappers/product_mapper.dart
extension ProductMapper on ProductDto {
  Product toEntity() => Product(
    id: id,
    name: title,
    description: description,
    price: price,
    imageUrl: thumbnail,
  );
}

extension ProductListMapper on List<ProductDto> {
  List<Product> toEntities() => map((dto) => dto.toEntity()).toList();
}
```

**API Service**:
```dart
// data/datasources/remote/api_service.dart
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;
  
  @GET('/products')
  Future<ProductsResponse> getProducts(@Query('category') String? category);
  
  @GET('/products/{id}')
  Future<ProductDto> getProductById(@Path('id') String id);
}

@JsonSerializable()
class ProductsResponse {
  final List<ProductDto> products;
  
  ProductsResponse({required this.products});
  
  factory ProductsResponse.fromJson(Map<String, dynamic> json) => 
      _$ProductsResponseFromJson(json);
}
```

**Repository Implementation**:
```dart
// data/repositories/product_repository_impl.dart
@LazySingleton(as: IProductRepository)
class ProductRepositoryImpl implements IProductRepository {
  final ApiService _apiService;
  
  ProductRepositoryImpl(this._apiService);
  
  @override
  ResultFuture<List<Product>> getProducts({String? category}) {
    return guardDio(() async {
      final response = await _apiService.getProducts(category);
      return response.products.toEntities();
    });
  }
  
  @override
  ResultFuture<Product> getProductById(String id) {
    return guardDio(() async {
      final dto = await _apiService.getProductById(id);
      return dto.toEntity();
    });
  }
}
```

#### 3. Presentation Layer

**BLoC Events**:
```dart
// presentation/bloc/products/products_event.dart
abstract class ProductsEvent extends Equatable {}

class ProductsRequested extends ProductsEvent {
  final String? category;
  
  ProductsRequested({this.category});
  
  @override
  List<Object?> get props => [category];
}

class ProductsRefreshed extends ProductsEvent {
  @override
  List<Object> get props => [];
}
```

**BLoC States**:
```dart
// presentation/bloc/products/products_state.dart
@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.loaded(List<Product> products) = _Loaded;
  const factory ProductsState.error(String message) = _Error;
}
```

**BLoC**:
```dart
// presentation/bloc/products/products_bloc.dart
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUsecase _getProductsUsecase;
  
  ProductsBloc(this._getProductsUsecase) : super(const ProductsState.initial()) {
    on<ProductsRequested>(_onProductsRequested);
    on<ProductsRefreshed>(_onProductsRefreshed);
  }
  
  Future<void> _onProductsRequested(
    ProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsState.loading());
    
    final result = await _getProductsUsecase(
      GetProductsParams(category: event.category),
    );
    
    result.fold(
      (failure) => emit(ProductsState.error(failure.message)),
      (products) => emit(ProductsState.loaded(products)),
    );
  }
  
  Future<void> _onProductsRefreshed(
    ProductsRefreshed event,
    Emitter<ProductsState> emit,
  ) async {
    // Refresh logic without showing loading state
    final result = await _getProductsUsecase(const GetProductsParams());
    
    result.fold(
      (failure) => emit(ProductsState.error(failure.message)),
      (products) => emit(ProductsState.loaded(products)),
    );
  }
}
```

**Screen**:
```dart
// presentation/screens/products/products_screen.dart
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(getIt<GetProductsUsecase>())
        ..add(ProductsRequested()),
      child: const ProductsView(),
    );
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (products) => ProductsList(products: products),
            error: (message) => ErrorWidget(message: message),
          );
        },
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;
  
  const ProductsList({Key? key, required this.products}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}
```

## 🧪 Testing Strategy

Clean Architecture makes testing straightforward by providing clear boundaries and dependencies:

### Unit Testing

#### Domain Layer Tests
```dart
// test/unit/domain/usecase/get_products_usecase_test.dart
void main() {
  group('GetProductsUsecase', () {
    late GetProductsUsecase usecase;
    late MockProductRepository mockRepository;
    
    setUp(() {
      mockRepository = MockProductRepository();
      usecase = GetProductsUsecase(mockRepository);
    });
    
    test('should return products when repository call is successful', () async {
      // Arrange
      final expectedProducts = [
        const Product(id: '1', name: 'Test Product', description: 'Test', price: 10.0, imageUrl: 'url'),
      ];
      
      when(() => mockRepository.getProducts(category: any(named: 'category')))
          .thenAnswer((_) async => Right(expectedProducts));
      
      // Act
      final result = await usecase(const GetProductsParams());
      
      // Assert
      expect(result, Right(expectedProducts));
      verify(() => mockRepository.getProducts(category: null)).called(1);
    });
    
    test('should return failure when repository call fails', () async {
      // Arrange
      final failure = NetworkFailure();
      
      when(() => mockRepository.getProducts(category: any(named: 'category')))
          .thenAnswer((_) async => Left(failure));
      
      // Act
      final result = await usecase(const GetProductsParams());
      
      // Assert
      expect(result, Left(failure));
    });
  });
}
```

#### Data Layer Tests
```dart
// test/unit/data/repositories/product_repository_impl_test.dart
void main() {
  group('ProductRepositoryImpl', () {
    late ProductRepositoryImpl repository;
    late MockApiService mockApiService;
    
    setUp(() {
      mockApiService = MockApiService();
      repository = ProductRepositoryImpl(mockApiService);
    });
    
    test('should return products when API call is successful', () async {
      // Arrange
      final productsResponse = ProductsResponse(products: [
        ProductDto(id: '1', title: 'Test', description: 'Test', price: 10.0, thumbnail: 'url'),
      ]);
      
      when(() => mockApiService.getProducts(any()))
          .thenAnswer((_) async => productsResponse);
      
      // Act
      final result = await repository.getProducts();
      
      // Assert
      result.fold(
        (failure) => fail('Expected success but got failure'),
        (products) {
          expect(products.length, 1);
          expect(products.first.name, 'Test');
        },
      );
    });
  });
}
```

#### Presentation Layer Tests
```dart
// test/unit/presentation/bloc/products_bloc_test.dart
void main() {
  group('ProductsBloc', () {
    late ProductsBloc bloc;
    late MockGetProductsUsecase mockUsecase;
    
    setUp(() {
      mockUsecase = MockGetProductsUsecase();
      bloc = ProductsBloc(mockUsecase);
    });
    
    blocTest<ProductsBloc, ProductsState>(
      'emits [loading, loaded] when ProductsRequested is successful',
      build: () => bloc,
      act: (bloc) {
        when(() => mockUsecase(any()))
            .thenAnswer((_) async => const Right([]));
        
        bloc.add(ProductsRequested());
      },
      expect: () => [
        const ProductsState.loading(),
        const ProductsState.loaded([]),
      ],
    );
  });
}
```

### Widget Testing
```dart
// test/widget/screens/products_screen_test.dart
void main() {
  group('ProductsScreen', () {
    testWidgets('should display loading indicator initially', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => MockProductsBloc(),
            child: const ProductsView(),
          ),
        ),
      );
      
      // Act & Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    
    testWidgets('should display products when loaded', (tester) async {
      // Arrange
      final mockBloc = MockProductsBloc();
      whenListen(
        mockBloc,
        Stream.fromIterable([
          const ProductsState.loaded([
            Product(id: '1', name: 'Test Product', description: 'Test', price: 10.0, imageUrl: 'url'),
          ]),
        ]),
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ProductsBloc>.value(
            value: mockBloc,
            child: const ProductsView(),
          ),
        ),
      );
      
      // Act
      await tester.pump();
      
      // Assert
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.byType(ProductCard), findsOneWidget);
    });
  });
}
```

### Integration Testing
```dart
// test/integration/login_flow_test.dart
void main() {
  group('Login Flow Integration Test', () {
    testWidgets('complete login flow', (tester) async {
      // Setup
      await tester.pumpWidget(MyApp());
      
      // Navigate to login screen
      expect(find.byType(LoginScreen), findsOneWidget);
      
      // Enter credentials
      await tester.enterText(find.byKey(const Key('username_field')), 'testuser');
      await tester.enterText(find.byKey(const Key('password_field')), 'password');
      
      // Tap login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();
      
      // Verify navigation to home screen
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
```

## ✅ Best Practices

### 1. Dependency Direction

**✅ Do**: Dependencies point inward
```dart
// Presentation depends on Domain
class LoginBloc {
  final LoginUserUsecase _usecase; // Domain interface
}

// Data implements Domain interfaces
class AuthRepositoryImpl implements IAuthRepository { // Domain interface
  final ApiService _apiService; // Data layer service
}
```

**❌ Don't**: Let inner layers depend on outer layers
```dart
// Domain depending on Data layer (WRONG)
class LoginUserUsecase {
  final ApiService _apiService; // Data layer dependency
}

// Domain depending on Presentation layer (WRONG)
class User {
  final LoginBloc _bloc; // Presentation layer dependency
}
```

### 2. Pure Domain Layer

**✅ Do**: Keep domain layer pure (no external dependencies)
```dart
// Pure domain entity
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  
  const User({required this.id, required this.name, required this.email});
  
  @override
  List<Object> get props => [id, name, email];
}

// Pure use case
class LoginUserUsecase extends UsecaseAsync<User, LoginCredentials> {
  final IAuthRepository _repository; // Domain interface only
  
  LoginUserUsecase(this._repository);
  
  @override
  ResultFuture<User> call(LoginCredentials params) {
    return _repository.login(params);
  }
}
```

**❌ Don't**: Add framework dependencies to domain
```dart
// Domain entity with Flutter dependency (WRONG)
class User extends ChangeNotifier { // Flutter dependency
  String _name = '';
  
  void updateName(String name) {
    _name = name;
    notifyListeners(); // Flutter-specific code
  }
}
```

### 3. Error Handling

**✅ Do**: Use consistent error handling pattern
```dart
// Define domain failures
abstract class Failures {
  final String message;
  Failures(this.message);
}

class NetworkFailure extends Failures {
  NetworkFailure() : super('Network connection failed');
}

// Use Either for error handling
typedef ResultFuture<T> = Future<Either<Failures, T>>;

// Handle errors consistently
@override
ResultFuture<User> login(LoginCredentials credentials) {
  return guardDio(() async {
    final dto = await _apiService.login(credentials.toRequest());
    return dto.toEntity();
  });
}
```

**❌ Don't**: Use exceptions for business logic errors
```dart
// Using exceptions for business logic (WRONG)
@override
Future<User> login(LoginCredentials credentials) async {
  if (credentials.username.isEmpty) {
    throw Exception('Username is required'); // Exception for business rule
  }
  
  final dto = await _apiService.login(credentials.toRequest());
  return dto.toEntity();
}
```

### 4. State Management

**✅ Do**: Use BLoC pattern with clear events and states
```dart
// Clear, specific events
abstract class LoginEvent extends Equatable {}

class LoginRequested extends LoginEvent {
  final String username;
  final String password;
  
  LoginRequested(this.username, this.password);
  
  @override
  List<Object> get props => [username, password];
}

// Immutable states with freezed
@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(User user) = _Success;
  const factory LoginState.error(String message) = _Error;
}
```

**❌ Don't**: Put business logic in BLoC
```dart
// Business logic in BLoC (WRONG)
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    // Business logic should be in use case, not here
    if (event.username.length < 3) {
      emit(LoginError('Username too short'));
      return;
    }
    
    if (!event.username.contains('@')) {
      emit(LoginError('Invalid email format'));
      return;
    }
    
    // Direct API call (should go through use case)
    final response = await http.post('/login', body: {...});
  }
}
```

### 5. Dependency Injection

**✅ Do**: Use proper DI with interfaces
```dart
// Register interfaces with implementations
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository { ... }

@Injectable()
class LoginUserUsecase {
  final IAuthRepository _repository; // Depend on interface
  
  LoginUserUsecase(this._repository);
}

// Use in presentation layer
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _usecase;
  
  LoginBloc(this._usecase) : super(LoginInitial());
}
```

**❌ Don't**: Use service locator pattern everywhere
```dart
// Service locator anti-pattern (WRONG)
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    final usecase = getIt<LoginUserUsecase>(); // Service locator
    final repository = getIt<IAuthRepository>(); // Service locator
    final apiService = getIt<ApiService>(); // Service locator
    
    // Use services...
  }
}
```

## ❌ Common Pitfalls

### 1. Circular Dependencies

**Problem**: Layers depending on each other
```dart
// WRONG: Circular dependency
class AuthRepository {
  final LoginBloc _bloc; // Data layer depending on Presentation
}

class LoginBloc {
  final AuthRepository _repository; // Presentation depending on Data
}
```

**Solution**: Use proper dependency direction
```dart
// CORRECT: Proper dependency flow
abstract class IAuthRepository { ... } // Domain

class AuthRepositoryImpl implements IAuthRepository { ... } // Data implements Domain

class LoginBloc {
  final LoginUserUsecase _usecase; // Presentation depends on Domain
}

class LoginUserUsecase {
  final IAuthRepository _repository; // Domain depends on Domain interface
}
```

### 2. Anemic Domain Model

**Problem**: Domain layer with no business logic
```dart
// WRONG: Anemic domain
class User {
  String id;
  String name;
  String email;
  
  User(this.id, this.name, this.email);
}

class UserService {
  bool isValidUser(User user) {
    return user.email.contains('@') && user.name.isNotEmpty;
  }
}
```

**Solution**: Rich domain model with business logic
```dart
// CORRECT: Rich domain model
class User extends Equatable {
  final String id;
  final String name;
  final Email email; // Value object with validation
  
  const User({required this.id, required this.name, required this.email});
  
  bool get isActive => email.isVerified && name.isNotEmpty;
  
  User updateEmail(Email newEmail) {
    return User(id: id, name: name, email: newEmail);
  }
  
  @override
  List<Object> get props => [id, name, email];
}

class Email extends Equatable {
  final String value;
  final bool isVerified;
  
  const Email({required this.value, required this.isVerified});
  
  factory Email.create(String value) {
    if (!value.contains('@')) {
      throw ArgumentError('Invalid email format');
    }
    return Email(value: value, isVerified: false);
  }
  
  @override
  List<Object> get props => [value, isVerified];
}
```

### 3. Fat Controllers/BLoCs

**Problem**: BLoC containing business logic
```dart
// WRONG: Business logic in BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    // Validation logic (should be in domain)
    if (event.username.length < 3) {
      emit(LoginError('Username too short'));
      return;
    }
    
    // Business rules (should be in use case)
    if (event.username.startsWith('admin_')) {
      emit(LoginError('Admin login not allowed from mobile'));
      return;
    }
    
    // Direct data access (should go through repository)
    final response = await http.post('/login');
  }
}
```

**Solution**: Thin BLoC with use case delegation
```dart
// CORRECT: Thin BLoC delegating to use case
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _loginUsecase;
  
  LoginBloc(this._loginUsecase) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }
  
  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    
    final result = await _loginUsecase(LoginCredentials(
      username: event.username,
      password: event.password,
    ));
    
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}

// Business logic in use case
class LoginUserUsecase extends UsecaseAsync<User, LoginCredentials> {
  final IAuthRepository _repository;
  
  LoginUserUsecase(this._repository);
  
  @override
  ResultFuture<User> call(LoginCredentials params) async {
    // Validation
    if (params.username.length < 3) {
      return Left(ValidationFailure('Username too short'));
    }
    
    // Business rules
    if (params.username.startsWith('admin_')) {
      return Left(BusinessRuleFailure('Admin login not allowed from mobile'));
    }
    
    // Delegate to repository
    return _repository.login(params);
  }
}
```

### 4. Leaky Abstractions

**Problem**: Implementation details leaking through interfaces
```dart
// WRONG: Leaky abstraction
abstract class IUserRepository {
  Future<Either<DioException, UserDto>> getUser(String id); // Dio-specific error and DTO
}
```

**Solution**: Clean abstractions
```dart
// CORRECT: Clean abstraction
abstract class IUserRepository {
  ResultFuture<User> getUser(String id); // Domain types only
}
```

## 🚀 Benefits

### 1. Testability
- **Easy unit testing**: Each layer can be tested in isolation
- **Mock dependencies**: Interfaces make mocking straightforward
- **Fast tests**: Domain logic tests don't require Flutter framework

### 2. Maintainability
- **Clear boundaries**: Each layer has specific responsibilities
- **Loose coupling**: Changes in one layer don't affect others
- **Easy to understand**: Consistent patterns throughout the codebase

### 3. Scalability
- **Team collaboration**: Different teams can work on different layers
- **Feature addition**: New features follow established patterns
- **Code reuse**: Domain logic can be shared across platforms

### 4. Flexibility
- **Technology changes**: Easy to swap implementations
- **Platform support**: Domain logic works on any platform
- **API changes**: Only data layer needs updates

### 5. Business Focus
- **Domain-driven**: Business logic is central and protected
- **Technology independence**: Business rules don't depend on frameworks
- **Clear business model**: Entities and use cases reflect business concepts

---

This Clean Architecture implementation provides a solid foundation for building scalable, maintainable, and testable Flutter applications. By following these principles and patterns, you'll create code that's easy to understand, modify, and extend as your application grows.
