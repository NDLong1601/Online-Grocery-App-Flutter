# 🏗️ Hướng Dẫn Flutter Clean Architecture

Hướng dẫn toàn diện này giải thích việc triển khai Clean Architecture trong dự án Flutter của chúng ta, bao gồm các nguyên tắc, patterns và ví dụ thực tế cho các developer ở mọi cấp độ.

## 📋 Mục Lục

- [🎯 Clean Architecture là gì?](#-clean-architecture-là-gì)
- [🏛️ Các Lớp Kiến Trúc](#️-các-lớp-kiến-trúc)
- [📐 Nguyên Tắc SOLID](#-nguyên-tắc-solid)
- [🔄 Luồng Dữ Liệu](#-luồng-dữ-liệu)
- [📁 Cấu Trúc Dự Án](#-cấu-trúc-dự-án)
- [🛠️ Chi Tiết Triển Khai](#️-chi-tiết-triển-khai)
- [📊 Ví Dụ Thực Tế](#-ví-dụ-thực-tế)
- [🧪 Chiến Lược Testing](#-chiến-lược-testing)
- [✅ Best Practices](#-best-practices)
- [❌ Những Lỗi Thường Gặp](#-những-lỗi-thường-gặp)
- [🚀 Lợi Ích](#-lợi-ích)

## 🎯 Clean Architecture là gì?

Clean Architecture là một triết lý thiết kế phần mềm được tạo ra bởi Robert C. Martin (Uncle Bob) nhấn mạnh vào việc tách biệt các mối quan tâm và đảo ngược phụ thuộc. Nó tạo ra các hệ thống:

- **Độc lập với Frameworks**: Kiến trúc không phụ thuộc vào thư viện bên ngoài
- **Có thể kiểm thử**: Quy tắc nghiệp vụ có thể được kiểm thử mà không cần UI, database, hoặc các yếu tố bên ngoài
- **Độc lập với UI**: UI có thể thay đổi mà không thay đổi quy tắc nghiệp vụ
- **Độc lập với Database**: Quy tắc nghiệp vụ không ràng buộc với database
- **Độc lập với External Agency**: Quy tắc nghiệp vụ không biết gì về thế giới bên ngoài

### Triết Lý Cốt Lõi

```
"Trung tâm của ứng dụng của bạn không phải là database. Cũng không phải là một hoặc nhiều frameworks mà bạn có thể sử dụng. Trung tâm của ứng dụng của bạn là các use cases của ứng dụng đó."
- Robert C. Martin
```

## 🏛️ Các Lớp Kiến Trúc

Flutter Clean Architecture của chúng ta bao gồm ba lớp chính, mỗi lớp có trách nhiệm cụ thể và các phụ thuộc chảy vào trong:

```
┌─────────────────────────────────────────────────────────┐
│                 🎨 LỚP PRESENTATION                      │
│                                                         │
│  • Các thành phần UI (Screens, Widgets)                │
│  • Quản lý trạng thái (BLoC/Cubit)                     │
│  • Routes & Navigation                                  │
│  • Xử lý đầu vào người dùng                            │
│                                                         │
│  Phụ thuộc: Lớp Domain                                 │
└─────────────────────┬───────────────────────────────────┘
                      │ Phụ thuộc vào
                      ▼
┌─────────────────────────────────────────────────────────┐
│                 🎯 LỚP DOMAIN                           │
│                                                         │
│  • Business Logic (Use Cases)                          │
│  • Entities & Value Objects                            │
│  • Repository Interfaces                               │
│  • Core Abstractions                                   │
│                                                         │
│  Phụ thuộc: Không có (Pure Dart)                      │
└─────────────────────▲───────────────────────────────────┘
                      │ Implements
                      │
┌─────────────────────────────────────────────────────────┐
│                 💾 LỚP DATA                             │
│                                                         │
│  • Repository Implementations                           │
│  • Data Sources (Remote API, Local Storage)            │
│  • Models & Mappers                                     │
│  • Tích hợp dịch vụ bên ngoài                          │
│                                                         │
│  Phụ thuộc: Lớp Domain                                 │
└─────────────────────────────────────────────────────────┘
```

### 🎨 Lớp Presentation

**Trách nhiệm**: Xử lý giao diện người dùng và tương tác người dùng

**Các thành phần**:
- **Screens/Pages**: Layouts UI và các thành phần visual
- **BLoC/Cubit**: Quản lý trạng thái và điều phối logic UI
- **Routes**: Cấu hình navigation
- **Widgets**: Các thành phần UI tái sử dụng
- **Theme**: Styling visual và theming

**Đặc điểm chính**:
- Chỉ phụ thuộc vào lớp Domain
- Không chứa business logic
- Xử lý đầu vào người dùng và hiển thị dữ liệu
- Quản lý trạng thái UI

**Ví dụ cấu trúc**:
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

### 🎯 Lớp Domain

**Trách nhiệm**: Chứa business logic và quy tắc (Pure Dart)

**Các thành phần**:
- **Entities**: Các đối tượng nghiệp vụ cốt lõi
- **Use Cases**: Các hoạt động và quy trình nghiệp vụ
- **Repository Interfaces**: Các contract truy cập dữ liệu
- **Value Objects**: Các kiểu dữ liệu đặc thù domain
- **Core**: Tiện ích và abstractions cấp domain

**Đặc điểm chính**:
- Không phụ thuộc vào external frameworks
- Chứa business logic thuần túy
- Định nghĩa contracts cho truy cập dữ liệu
- Không phụ thuộc framework

**Ví dụ cấu trúc**:
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

### 💾 Lớp Data

**Trách nhiệm**: Xử lý truy cập dữ liệu và dịch vụ bên ngoài

**Các thành phần**:
- **Repository Implementations**: Implement các interface repository domain
- **Data Sources**: Xử lý dữ liệu bên ngoài (API, Database, Storage)
- **Models**: Data transfer objects với serialization
- **Mappers**: Chuyển đổi giữa models và entities
- **Core**: Tiện ích lớp data và xử lý lỗi

**Đặc điểm chính**:
- Implement các contract domain
- Xử lý external dependencies
- Quản lý chuyển đổi dữ liệu
- Không chứa business logic

**Ví dụ cấu trúc**:
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

## 📐 Nguyên Tắc SOLID

Clean Architecture được xây dựng trên các nguyên tắc SOLID. Đây là cách chúng áp dụng vào dự án Flutter của chúng ta:

### S - Single Responsibility Principle (Nguyên tắc Trách nhiệm Đơn lẻ)

**"Một class chỉ nên có một, và chỉ một, lý do để thay đổi."**

**Ví dụ**:
```dart
// ✅ Tốt - Trách nhiệm đơn lẻ
class LoginUserUsecase {
  // Chỉ chịu trách nhiệm cho business logic đăng nhập
  ResultFuture<User> call(LoginCredentials credentials) { ... }
}

class LoginBloc {
  // Chỉ chịu trách nhiệm cho quản lý trạng thái UI đăng nhập
  void add(LoginEvent event) { ... }
}

class ApiService {
  // Chỉ chịu trách nhiệm cho giao tiếp API
  Future<LoginDto> login(LoginRequest request) { ... }
}

// ❌ Xấu - Nhiều trách nhiệm
class LoginManager {
  // Vi phạm SRP - xử lý UI, business logic, và API calls
  void showLoginForm() { ... }
  User validateCredentials() { ... }
  Future<LoginDto> callLoginApi() { ... }
}
```

### O - Open/Closed Principle (Nguyên tắc Mở/Đóng)

**"Các thực thể phần mềm nên mở để mở rộng, nhưng đóng để sửa đổi."**

**Ví dụ**:
```dart
// ✅ Tốt - Mở để mở rộng thông qua interfaces
abstract class IAuthRepository {
  ResultFuture<User> login(LoginCredentials credentials);
}

class ApiAuthRepository implements IAuthRepository { ... }
class MockAuthRepository implements IAuthRepository { ... }
class CachedAuthRepository implements IAuthRepository { ... }

// ✅ Tốt - Mở rộng chức năng mà không sửa đổi code hiện tại
abstract class AppLogger {
  void log(String message);
}

class ConsoleLogger implements AppLogger { ... }
class FileLogger implements AppLogger { ... }
class RemoteLogger implements AppLogger { ... }
```

### L - Liskov Substitution Principle (Nguyên tắc Thay thế Liskov)

**"Các đối tượng của superclass nên có thể thay thế bằng các đối tượng của subclasses."**

**Ví dụ**:
```dart
// ✅ Tốt - Các implementations có thể thay thế
abstract class ILocalStorage {
  ResultFuture<String?> getString(String key);
}

class SharedPreferencesStorage implements ILocalStorage {
  @override
  ResultFuture<String?> getString(String key) {
    // Implementation sử dụng SharedPreferences
  }
}

class SecureStorage implements ILocalStorage {
  @override
  ResultFuture<String?> getString(String key) {
    // Implementation sử dụng FlutterSecureStorage
  }
}

// Cả hai đều có thể sử dụng thay thế cho nhau
ILocalStorage storage = SharedPreferencesStorage(); // hoặc SecureStorage()
final result = await storage.getString('key');
```

### I - Interface Segregation Principle (Nguyên tắc Phân tách Interface)

**"Nhiều interface chuyên biệt cho client tốt hơn một interface đa năng."**

**Ví dụ**:
```dart
// ✅ Tốt - Interfaces được phân tách
abstract class IUserReader {
  ResultFuture<User> getUser(String id);
}

abstract class IUserWriter {
  ResultFuture<void> saveUser(User user);
}

abstract class IUserDeleter {
  ResultFuture<void> deleteUser(String id);
}

// Clients chỉ phụ thuộc vào những gì chúng cần
class UserProfileUsecase {
  final IUserReader _userReader;
  UserProfileUsecase(this._userReader); // Chỉ cần đọc
}

class SaveUserUsecase {
  final IUserWriter _userWriter;
  SaveUserUsecase(this._userWriter); // Chỉ cần ghi
}

// ❌ Xấu - Fat interface
abstract class IUserRepository {
  ResultFuture<User> getUser(String id);
  ResultFuture<void> saveUser(User user);
  ResultFuture<void> deleteUser(String id);
  ResultFuture<List<User>> getAllUsers();
  ResultFuture<void> exportUsers();
  ResultFuture<void> importUsers();
  // ... nhiều methods khác
}
```

### D - Dependency Inversion Principle (Nguyên tắc Đảo ngược Phụ thuộc)

**"Phụ thuộc vào abstractions, không phải concretions."**

**Ví dụ**:
```dart
// ✅ Tốt - Phụ thuộc vào abstraction
class LoginBloc {
  final LoginUserUsecase _loginUsecase; // Abstraction
  
  LoginBloc(this._loginUsecase);
}

class LoginUserUsecase {
  final IAuthRepository _repository; // Abstraction
  
  LoginUserUsecase(this._repository);
}

// ❌ Xấu - Phụ thuộc vào concretion
class LoginBloc {
  final ApiService _apiService; // Concretion
  final SharedPreferences _prefs; // Concretion
  
  LoginBloc(this._apiService, this._prefs);
}
```

## 🔄 Luồng Dữ Liệu

Hiểu luồng dữ liệu là rất quan trọng cho Clean Architecture. Đây là cách dữ liệu di chuyển qua các lớp của chúng ta:

### Luồng Dữ Liệu Vào Trong (User Input)

```
User Input → Presentation → Domain → Data → External Services
```

**Ví dụ: Luồng Đăng nhập Người dùng**

1. **Hành động người dùng**: Người dùng nhấn nút đăng nhập
2. **Lớp Presentation**: BLoC nhận login event
3. **Lớp Domain**: Use case thực thi business logic
4. **Lớp Data**: Repository gọi API service
5. **External Service**: API xác thực credentials
6. **Đường trở về**: Dữ liệu chảy ngược qua các lớp

```dart
// 1. Người dùng nhấn nút đăng nhập
onPressed: () => context.read<LoginBloc>().add(LoginRequested(username, password))

// 2. BLoC xử lý event
Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
  emit(LoginLoading());
  
  // 3. Gọi use case
  final result = await _loginUsecase(LoginCredentials(
    username: event.username,
    password: event.password,
  ));
  
  // 6. Xử lý kết quả
  result.fold(
    (failure) => emit(LoginError(failure.message)),
    (user) => emit(LoginSuccess(user)),
  );
}

// 4. Use case thực thi
@override
ResultFuture<User> call(LoginCredentials params) {
  return _repository.login(params); // 5. Repository xử lý truy cập dữ liệu
}
```

### Luồng Dữ Liệu Ra Ngoài (Data Updates)

```
External Services → Data → Domain → Presentation → UI Update
```

**Ví dụ: Cập nhật Dữ liệu Real-time**

1. **External Event**: Server gửi push notification
2. **Lớp Data**: Repository nhận và xử lý dữ liệu
3. **Lớp Domain**: Use case xác thực và chuyển đổi dữ liệu
4. **Lớp Presentation**: BLoC cập nhật state
5. **UI Update**: Widgets rebuild với dữ liệu mới

## 📁 Cấu Trúc Dự Án

Clean Architecture của chúng ta được phản ánh trong cấu trúc dự án:

```
lib/
├── 🎯 domain/                    # Lớp Business Logic
│   ├── core/                    # Domain abstractions
│   │   ├── app_logger.dart      # Logger interface
│   │   ├── failures.dart        # Các loại lỗi
│   │   ├── result.dart          # Định nghĩa kiểu Result
│   │   └── usecase.dart         # Base classes cho Use case
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
├── 💾 data/                      # Lớp Truy cập Dữ liệu
│   ├── core/                    # Tiện ích data
│   │   ├── guard.dart           # Xử lý lỗi
│   │   ├── interceptors.dart    # HTTP interceptors
│   │   └── exceptions.dart      # Custom exceptions
│   ├── datasources/             # Implementations data source
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
│   ├── mappers/                 # Chuyển đổi dữ liệu
│   │   └── login_mapper.dart
│   └── repositories/            # Repository implementations
│       ├── auth_repository_impl.dart
│       └── product_repository_impl.dart
│
├── 🎨 presentation/              # Lớp UI
│   ├── bloc/                    # Quản lý trạng thái
│   │   ├── login/
│   │   │   ├── login_bloc.dart
│   │   │   ├── login_event.dart
│   │   │   └── login_state.dart
│   │   └── products/
│   ├── screens/                 # Các màn hình UI
│   │   ├── login/
│   │   │   └── login_screen.dart
│   │   └── products/
│   ├── shared/                  # Các thành phần tái sử dụng
│   │   ├── widgets/
│   │   └── components/
│   └── routes/                  # Navigation
│       └── app_router.dart
│
└── 💉 di/                        # Dependency Injection
    ├── injector.dart            # Cấu hình DI
    ├── injector.config.dart     # Code DI được sinh
    ├── domain_module.dart       # Dependencies domain
    ├── env_module.dart          # Cấu hình môi trường
    └── third_party_module.dart  # Dependencies bên ngoài
```

## 🛠️ Chi Tiết Triển Khai

### Dependency Injection

Chúng ta sử dụng GetIt với Injectable cho dependency injection:

```dart
// 1. Định nghĩa interfaces trong domain layer
abstract class IAuthRepository {
  ResultFuture<User> login(LoginCredentials credentials);
}

// 2. Implement trong data layer
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final ApiService _apiService;
  
  AuthRepositoryImpl(this._apiService);
  
  @override
  ResultFuture<User> login(LoginCredentials credentials) {
    // Implementation
  }
}

// 3. Đăng ký use cases trong domain module
@module
abstract class DomainModule {
  @Injectable()
  LoginUserUsecase loginUserUsecase(IAuthRepository repository) {
    return LoginUserUsecase(repository);
  }
}

// 4. Sử dụng trong presentation layer
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final loginUsecase = getIt<LoginUserUsecase>();
    // Sử dụng use case
  }
}
```

### Xử Lý Lỗi

Chúng ta sử dụng Either pattern từ dartz cho xử lý lỗi:

```dart
// Định nghĩa kiểu result
typedef ResultEither<T> = Either<Failures, T>;
typedef ResultFuture<T> = Future<ResultEither<T>>;

// Các kiểu failure
abstract class Failures {
  final Object? cause;
  final StackTrace? stackTrace;
  Failures({this.cause, this.stackTrace});
}

class NetworkFailure extends Failures { ... }
class ServerFailure extends Failures { ... }
class CacheFailure extends Failures { ... }

// Sử dụng trong repository
@override
ResultFuture<User> login(LoginCredentials credentials) {
  return guardDio(() async {
    final dto = await _apiService.login(credentials.toRequest());
    return dto.toEntity();
  });
}

// Sử dụng trong BLoC
final result = await _loginUsecase(credentials);
result.fold(
  (failure) => emit(LoginError(_mapFailureToMessage(failure))),
  (user) => emit(LoginSuccess(user)),
);
```

### Quản Lý Trạng Thái với BLoC

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

// States (sử dụng Freezed cho tính bất biến)
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

## 📊 Ví Dụ Thực Tế

### Triển Khai Tính Năng Hoàn Chỉnh

Hãy triển khai tính năng "Lấy Sản phẩm" hoàn chỉnh theo Clean Architecture:

#### 1. Lớp Domain

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

#### 2. Lớp Data

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

#### 3. Lớp Presentation

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
      appBar: AppBar(title: const Text('Sản phẩm')),
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
```

## 🧪 Chiến Lược Testing

Clean Architecture làm cho việc testing trở nên đơn giản bằng cách cung cấp các ranh giới rõ ràng và dependencies:

### Unit Testing

#### Tests Lớp Domain
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
    
    test('nên trả về products khi repository call thành công', () async {
      // Arrange
      final expectedProducts = [
        const Product(id: '1', name: 'Sản phẩm Test', description: 'Test', price: 10.0, imageUrl: 'url'),
      ];
      
      when(() => mockRepository.getProducts(category: any(named: 'category')))
          .thenAnswer((_) async => Right(expectedProducts));
      
      // Act
      final result = await usecase(const GetProductsParams());
      
      // Assert
      expect(result, Right(expectedProducts));
      verify(() => mockRepository.getProducts(category: null)).called(1);
    });
  });
}
```

#### Tests Lớp Presentation
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
      'phát ra [loading, loaded] khi ProductsRequested thành công',
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

## ✅ Best Practices

### 1. Hướng Phụ thuộc

**✅ Nên**: Phụ thuộc hướng vào trong
```dart
// Presentation phụ thuộc vào Domain
class LoginBloc {
  final LoginUserUsecase _usecase; // Domain interface
}

// Data implements Domain interfaces
class AuthRepositoryImpl implements IAuthRepository { // Domain interface
  final ApiService _apiService; // Data layer service
}
```

**❌ Không nên**: Để các lớp bên trong phụ thuộc vào lớp bên ngoài
```dart
// Domain phụ thuộc vào Data layer (SAI)
class LoginUserUsecase {
  final ApiService _apiService; // Data layer dependency
}

// Domain phụ thuộc vào Presentation layer (SAI)
class User {
  final LoginBloc _bloc; // Presentation layer dependency
}
```

### 2. Lớp Domain Thuần Túy

**✅ Nên**: Giữ lớp domain thuần túy (không có external dependencies)
```dart
// Entity domain thuần túy
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  
  const User({required this.id, required this.name, required this.email});
  
  @override
  List<Object> get props => [id, name, email];
}

// Use case thuần túy
class LoginUserUsecase extends UsecaseAsync<User, LoginCredentials> {
  final IAuthRepository _repository; // Chỉ domain interface
  
  LoginUserUsecase(this._repository);
  
  @override
  ResultFuture<User> call(LoginCredentials params) {
    return _repository.login(params);
  }
}
```

**❌ Không nên**: Thêm framework dependencies vào domain
```dart
// Domain entity với Flutter dependency (SAI)
class User extends ChangeNotifier { // Flutter dependency
  String _name = '';
  
  void updateName(String name) {
    _name = name;
    notifyListeners(); // Flutter-specific code
  }
}
```

## ❌ Những Lỗi Thường Gặp

### 1. Phụ thuộc Vòng tròn

**Vấn đề**: Các lớp phụ thuộc lẫn nhau
```dart
// SAI: Phụ thuộc vòng tròn
class AuthRepository {
  final LoginBloc _bloc; // Data layer phụ thuộc vào Presentation
}

class LoginBloc {
  final AuthRepository _repository; // Presentation phụ thuộc vào Data
}
```

**Giải pháp**: Sử dụng hướng phụ thuộc đúng
```dart
// ĐÚNG: Luồng phụ thuộc đúng
abstract class IAuthRepository { ... } // Domain

class AuthRepositoryImpl implements IAuthRepository { ... } // Data implements Domain

class LoginBloc {
  final LoginUserUsecase _usecase; // Presentation phụ thuộc vào Domain
}

class LoginUserUsecase {
  final IAuthRepository _repository; // Domain phụ thuộc vào Domain interface
}
```

### 2. Anemic Domain Model

**Vấn đề**: Lớp domain không có business logic
```dart
// SAI: Anemic domain
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

**Giải pháp**: Rich domain model với business logic
```dart
// ĐÚNG: Rich domain model
class User extends Equatable {
  final String id;
  final String name;
  final Email email; // Value object với validation
  
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
      throw ArgumentError('Định dạng email không hợp lệ');
    }
    return Email(value: value, isVerified: false);
  }
  
  @override
  List<Object> get props => [value, isVerified];
}
```

## 🚀 Lợi Ích

### 1. Khả năng Kiểm thử
- **Unit testing dễ dàng**: Mỗi lớp có thể được test riêng biệt
- **Mock dependencies**: Interfaces làm cho việc mocking trở nên đơn giản
- **Tests nhanh**: Tests domain logic không cần Flutter framework

### 2. Khả năng Bảo trì
- **Ranh giới rõ ràng**: Mỗi lớp có trách nhiệm cụ thể
- **Loose coupling**: Thay đổi trong một lớp không ảnh hưởng đến lớp khác
- **Dễ hiểu**: Patterns nhất quán trong toàn bộ codebase

### 3. Khả năng Mở rộng
- **Hợp tác nhóm**: Các nhóm khác nhau có thể làm việc trên các lớp khác nhau
- **Thêm tính năng**: Tính năng mới tuân theo các patterns đã thiết lập
- **Tái sử dụng code**: Domain logic có thể được chia sẻ giữa các platforms

### 4. Tính Linh hoạt
- **Thay đổi công nghệ**: Dễ dàng thay đổi implementations
- **Hỗ trợ platform**: Domain logic hoạt động trên bất kỳ platform nào
- **Thay đổi API**: Chỉ cần cập nhật data layer

### 5. Tập trung vào Business
- **Domain-driven**: Business logic là trung tâm và được bảo vệ
- **Độc lập công nghệ**: Quy tắc nghiệp vụ không phụ thuộc vào frameworks
- **Mô hình nghiệp vụ rõ ràng**: Entities và use cases phản ánh các khái niệm nghiệp vụ

---

Việc triển khai Clean Architecture này cung cấp một nền tảng vững chắc để xây dựng các ứng dụng Flutter có thể mở rộng, bảo trì và kiểm thử được. Bằng cách tuân theo các nguyên tắc và patterns này, bạn sẽ tạo ra code dễ hiểu, sửa đổi và mở rộng khi ứng dụng của bạn phát triển.
