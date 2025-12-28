# 🛠️ Tech Stack Documentation

This document provides a comprehensive overview of all technologies, packages, and tools used in the Online Grocery Store App, including usage examples and implementation details.

## 📋 Table of Contents

- [🏗️ Core Framework](#️-core-framework)
- [🎯 Architecture & State Management](#-architecture--state-management)
- [🌐 Networking & API](#-networking--api)
- [💾 Data & Storage](#-data--storage)
- [⚡ Error Handling & Utilities](#-error-handling--utilities)
- [🎨 UI & User Experience](#-ui--user-experience)
- [🌍 Internationalization](#-internationalization)
- [🔧 Development Tools](#-development-tools)
- [📱 Platform-Specific](#-platform-specific)
- [🧪 Testing](#-testing)
- [📊 Code Examples](#-code-examples)

## 🏗️ Core Framework

### Flutter SDK ^3.8.1
**Purpose**: Cross-platform mobile application framework
**Why chosen**: 
- Single codebase for iOS and Android
- High performance with native compilation
- Rich widget ecosystem
- Strong community support

**Usage in project**:
```dart
// Main app entry point
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Grocery Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}
```

### Dart SDK ^3.8.1
**Purpose**: Programming language for Flutter development
**Why chosen**:
- Optimized for UI development
- Strong typing with null safety
- Excellent tooling and IDE support
- Async/await support for reactive programming

**Key features used**:
- Null safety
- Extension methods
- Sealed classes (with freezed)
- Async/await patterns
- Generic types

## 🎯 Architecture & State Management

### flutter_bloc ^9.0.0
**Purpose**: State management using BLoC (Business Logic Component) pattern
**Why chosen**:
- Predictable state management
- Separation of business logic from UI
- Excellent testing capabilities
- Event-driven architecture

**Implementation example**:
```dart
// BLoC Definition
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _loginUsecase;
  final ILocalStorage _localStorage;
  final FailureMapper _failureMapper;

  LoginBloc(this._loginUsecase, this._localStorage, this._failureMapper)
      : super(const LoginState()) {
    on<OnLoginEvent>(_onLoginEvent);
    on<OnClearLoginErrorMessage>(_onClearLoginErrorMessage);
  }

  Future<void> _onLoginEvent(OnLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    
    final result = await _loginUsecase.call(LoginCredentials(
      username: event.username,
      password: event.password,
      expiresInMins: 30,
    ));
    
    result.fold(
      (failure) => emit(state.copyWith(
        apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
      )),
      (success) async {
        await _localStorage.setAccessToken(success.accessToken);
        emit(state.copyWith(isSuccess: true));
      },
    );
    
    emit(state.copyWith(isLoading: false));
  }
}

// UI Usage
BlocBuilder<LoginBloc, LoginState>(
  builder: (context, state) {
    if (state.isLoading) {
      return const CircularProgressIndicator();
    }
    return LoginForm();
  },
)
```

### get_it ^8.0.1
**Purpose**: Service locator for dependency injection
**Why chosen**:
- Simple and lightweight
- Supports different registration types (singleton, factory, lazy singleton)
- Works well with injectable code generation
- No runtime reflection

**Usage patterns**:
```dart
// Registration
final getIt = GetIt.instance;

// Accessing dependencies
final loginUsecase = getIt<LoginUserUsecase>();
final localStorage = getIt<ILocalStorage>();
```

### injectable ^2.5.0
**Purpose**: Code generation for dependency injection
**Why chosen**:
- Reduces boilerplate code
- Compile-time dependency resolution
- Type-safe dependency registration
- Supports complex dependency graphs

**Configuration example**:
```dart
// Module definition
@module
abstract class ThirdPartyModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  
  FlutterSecureStorage secureStorage() => const FlutterSecureStorage();
  
  Dio dio(AppConfig appConfig, @Named('baseUrl') String baseUrl) {
    return Dio(BaseOptions(baseUrl: baseUrl));
  }
}

// Service registration
@Singleton(as: ILocalStorage)
class LocalStorageImpl implements ILocalStorage {
  // Implementation
}
```

### equatable ^2.0.7
**Purpose**: Value equality for Dart objects
**Why chosen**:
- Simplifies object comparison
- Essential for BLoC state management
- Reduces boilerplate for equals/hashCode
- Improves performance in state comparisons

**Usage example**:
```dart
class LoginEntity extends Equatable {
  final int id;
  final String username;
  final String email;
  final String accessToken;

  const LoginEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [id, username, email, accessToken];
}
```

## 🌐 Networking & API

### dio ^5.7.0
**Purpose**: HTTP client for API communication
**Why chosen**:
- Powerful interceptor system
- Request/response transformation
- Automatic request retrying
- Built-in error handling
- Support for FormData, file uploads

**Configuration example**:
```dart
Dio createDio(String baseUrl, NetworkInterceptor networkInterceptor) {
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));
  
  dio.interceptors.addAll([
    networkInterceptor,
    prettyDioLoggerInterceptor(),
  ]);
  
  return dio;
}
```

### retrofit ^4.4.1
**Purpose**: Type-safe HTTP client generator
**Why chosen**:
- Compile-time API validation
- Automatic serialization/deserialization
- Clean API interface definition
- Reduces boilerplate code

**API service definition**:
```dart
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST('/auth/login')
  Future<LoginDto> login(@Body() LoginRequest request);
  
  @GET('/products')
  Future<List<ProductDto>> getProducts(@Query('category') String category);
  
  @POST('/orders')
  Future<OrderDto> createOrder(@Body() CreateOrderRequest request);
}
```

### pretty_dio_logger ^1.4.0
**Purpose**: HTTP request/response logging
**Why chosen**:
- Beautiful console output
- Configurable log levels
- Request/response body formatting
- Performance timing information

**Configuration**:
```dart
PrettyDioLogger prettyDioLoggerInterceptor() {
  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 90,
  );
}
```

## 💾 Data & Storage

### shared_preferences ^2.3.3
**Purpose**: Simple key-value storage for user preferences
**Why chosen**:
- Native platform storage (UserDefaults on iOS, SharedPreferences on Android)
- Simple API for basic data types
- Persistent across app launches
- Synchronous and asynchronous access

**Usage example**:
```dart
class LocalStorageDataSourceImpl implements ILocalStorageDataSource {
  final SharedPreferences _sharedPreferences;
  
  @override
  ResultFuture<void> storeString(String key, String value) async {
    return guardLocalStorage(() async {
      await _sharedPreferences.setString(key, value);
    });
  }
  
  @override
  ResultFuture<String?> retrieveString(String key) async {
    return guardLocalStorage(() async {
      return _sharedPreferences.getString(key);
    });
  }
}
```

### flutter_secure_storage ^9.2.3
**Purpose**: Secure storage for sensitive data
**Why chosen**:
- Encrypted storage (Keychain on iOS, Keystore on Android)
- Secure storage for tokens and passwords
- Biometric authentication support
- Cross-platform API

**Implementation**:
```dart
class LocalStorageDataSourceImpl implements ILocalStorageDataSource {
  final FlutterSecureStorage _secureStorage;
  
  static const String _accessTokenKey = 'access_token';
  
  @override
  ResultFuture<void> storeAccessToken(String accessToken) async {
    return guardLocalStorage(() async {
      await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    });
  }
  
  @override
  ResultFuture<String?> retrieveAccessToken() async {
    return guardLocalStorage(() async {
      return await _secureStorage.read(key: _accessTokenKey);
    });
  }
}
```

### json_annotation ^4.9.0
**Purpose**: JSON serialization annotations
**Why chosen**:
- Compile-time JSON serialization
- Type-safe JSON handling
- Custom serialization logic
- Works with json_serializable

**Model definition**:
```dart
@JsonSerializable()
class LoginDto {
  final int id;
  final String username;
  final String email;
  final String accessToken;
  final String refreshToken;

  LoginDto({
    required this.id,
    required this.username,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) => _$LoginDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
```

## ⚡ Error Handling & Utilities

### dartz ^0.10.1
**Purpose**: Functional programming utilities (Either, Option)
**Why chosen**:
- Railway-oriented programming for error handling
- Eliminates null pointer exceptions
- Composable error handling
- Functional programming patterns

**Error handling pattern**:
```dart
// Result type definition
typedef ResultEither<T> = Either<Failures, T>;
typedef ResultFuture<T> = Future<ResultEither<T>>;

// Usage in repository
@override
ResultFuture<LoginEntity> login(LoginCredentials credentials) {
  return guardDio<LoginEntity>(() async {
    final request = LoginRequest(
      username: credentials.username,
      password: credentials.password,
    );
    final dto = await _apiService.login(request);
    return dto.toEntity();
  });
}

// Usage in BLoC
final result = await _loginUsecase.call(credentials);
result.fold(
  (failure) => emit(LoginState.error(failure.message)),
  (success) => emit(LoginState.success(success)),
);
```

### freezed ^2.5.8
**Purpose**: Code generation for immutable classes
**Why chosen**:
- Immutable data classes with copyWith
- Union types for state management
- Pattern matching support
- Reduces boilerplate code

**State definition with freezed**:
```dart
@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(LoginEntity user) = _Success;
  const factory LoginState.error(String message) = _Error;
}

// Usage with pattern matching
state.when(
  initial: () => const LoginForm(),
  loading: () => const CircularProgressIndicator(),
  success: (user) => HomePage(user: user),
  error: (message) => ErrorWidget(message: message),
);
```

### logger ^2.5.0
**Purpose**: Logging framework
**Why chosen**:
- Configurable log levels
- Beautiful console output
- Custom log formatting
- Performance optimized

**Logger implementation**:
```dart
@LazySingleton(as: AppLogger)
class ConsoleAppLogger implements AppLogger {
  late final Logger _logger;

  ConsoleAppLogger() : _logger = Logger(
    level: Level.trace,
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  @override
  void i(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? metadata}) {
    _logger.i(_mixMetadata(message, metadata), error: error, stackTrace: stackTrace);
  }

  String _mixMetadata(Object message, Map<String, dynamic>? metadata) {
    return metadata == null ? '$message' : '$message | metadata: $metadata';
  }
}
```

## 🎨 UI & User Experience

### flutter_screenutil ^5.9.3
**Purpose**: Screen adaptation for different device sizes
**Why chosen**:
- Responsive design across devices
- Consistent UI scaling
- Easy size and font scaling
- Supports both width and height adaptation

**Usage example**:
```dart
// Initialize in main
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: HomePage(),
        );
      },
    );
  }
}

// Usage in widgets
Container(
  width: 200.w,        // Responsive width
  height: 100.h,       // Responsive height
  padding: EdgeInsets.all(16.r), // Responsive padding
  child: Text(
    'Hello World',
    style: TextStyle(fontSize: 16.sp), // Responsive font size
  ),
)
```

### cached_network_image ^3.4.1
**Purpose**: Image caching and loading with placeholder support
**Why chosen**:
- Automatic image caching
- Placeholder and error widgets
- Memory and disk cache management
- Progressive loading support

**Implementation**:
```dart
CachedNetworkImage(
  imageUrl: product.imageUrl,
  width: 120.w,
  height: 120.h,
  fit: BoxFit.cover,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
  cacheManager: DefaultCacheManager(),
)
```

### flutter_svg ^2.1.0
**Purpose**: SVG image support
**Why chosen**:
- Vector graphics support
- Scalable icons and illustrations
- Small file sizes
- Color customization

**Usage**:
```dart
SvgPicture.asset(
  'assets/icons/ic_cart.svg',
  width: 24.w,
  height: 24.h,
  colorFilter: ColorFilter.mode(
    Theme.of(context).primaryColor,
    BlendMode.srcIn,
  ),
)
```

### go_router ^15.0.0
**Purpose**: Declarative routing
**Why chosen**:
- Type-safe navigation
- Deep linking support
- Nested routing
- URL-based navigation

**Router configuration**:
```dart
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: '/product/:id',
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductDetailScreen(productId: productId);
          },
        ),
      ],
    ),
  ],
);

// Navigation usage
context.go('/home');
context.push('/product/123');
```

## 🌍 Internationalization

### flutter_localizations (SDK)
**Purpose**: Flutter's built-in localization support
**Why chosen**:
- Official Flutter localization
- Platform-specific formatting
- Date, number, and currency formatting
- RTL language support

### intl ^0.20.2
**Purpose**: Internationalization utilities
**Why chosen**:
- Message formatting and pluralization
- Date and number formatting
- Locale-specific formatting
- Works with flutter_localizations

**Localization setup**:
```dart
// l10n.yaml configuration
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart

// app_en.arb
{
  "loginTitle": "Login",
  "username": "Username",
  "password": "Password",
  "loginButton": "Login",
  "welcomeMessage": "Welcome, {name}!",
  "@welcomeMessage": {
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  }
}

// Usage in widgets
Text(context.l10n.loginTitle)
Text(context.l10n.welcomeMessage('John'))
```

**Context extension for easy access**:
```dart
extension ContextExtension on BuildContext {
  AppLocalizations? get appLocalizations => AppLocalizations.of(this);
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
```

## 🔧 Development Tools

### build_runner ^2.4.14
**Purpose**: Code generation runner
**Why chosen**:
- Runs code generators
- Watch mode for development
- Incremental builds
- Multiple generator support

**Usage commands**:
```bash
# One-time generation
dart run build_runner build

# Watch mode for development
dart run build_runner watch

# Clean and rebuild
dart run build_runner build --delete-conflicting-outputs
```

### injectable_generator ^2.7.0
**Purpose**: Dependency injection code generation
**Configuration**: Works with injectable annotations to generate dependency graph

### retrofit_generator ^9.1.7
**Purpose**: HTTP client code generation
**Configuration**: Generates implementation for retrofit API interfaces

### json_serializable ^6.9.3
**Purpose**: JSON serialization code generation
**Configuration**: Generates fromJson/toJson methods for models

### flutter_gen_runner ^5.11.0
**Purpose**: Asset code generation
**Why chosen**:
- Type-safe asset access
- Compile-time asset validation
- Auto-completion for assets
- Prevents runtime asset errors

**Configuration**:
```yaml
# pubspec.yaml
flutter_gen:
  output: lib/core/assets_gen/
  line_length: 80
  integrations:
    flutter_svg: true

# Generated usage
Image.asset(Assets.images.imgApple.path)
SvgPicture.asset(Assets.icons.icCart.path)
```

### flutter_lints ^5.0.0
**Purpose**: Dart linting rules
**Why chosen**:
- Consistent code style
- Catches common errors
- Best practice enforcement
- IDE integration

## 📱 Platform-Specific

### cupertino_icons ^1.0.8
**Purpose**: iOS-style icons
**Usage**: Provides Cupertino (iOS) style icons for cross-platform consistency

### share_plus ^11.0.0
**Purpose**: Native sharing functionality
**Why chosen**:
- Platform-native share dialogs
- Share text, files, and URLs
- Cross-platform API

**Usage example**:
```dart
await Share.share(
  'Check out this amazing product!',
  subject: 'Product Recommendation',
);

await Share.shareXFiles(
  [XFile('/path/to/image.jpg')],
  text: 'Product image',
);
```

## 🧪 Testing

### flutter_test (SDK)
**Purpose**: Flutter's built-in testing framework
**Capabilities**:
- Unit testing
- Widget testing
- Integration testing
- Mock support

**Test examples**:
```dart
// Unit test
testWidgets('Login button should trigger login event', (tester) async {
  await tester.pumpWidget(LoginScreen());
  
  await tester.enterText(find.byKey(Key('username')), 'testuser');
  await tester.enterText(find.byKey(Key('password')), 'password');
  await tester.tap(find.byKey(Key('loginButton')));
  
  verify(mockLoginBloc.add(any)).called(1);
});

// BLoC test
blocTest<LoginBloc, LoginState>(
  'emits success state when login succeeds',
  build: () => LoginBloc(mockUsecase, mockStorage, mockMapper),
  act: (bloc) => bloc.add(OnLoginEvent('user', 'pass')),
  expect: () => [
    LoginState(isLoading: true),
    LoginState(isSuccess: true, isLoading: false),
  ],
);
```

## 📊 Code Examples

### Complete Feature Implementation

Here's how all technologies work together in a complete feature:

```dart
// 1. Domain Layer - Use Case
class LoginUserUsecase extends UsecaseAsync<LoginEntity, LoginCredentials> {
  final IAuthRepository _authRepository;
  
  LoginUserUsecase(this._authRepository);
  
  @override
  ResultFuture<LoginEntity> call(LoginCredentials params) {
    return _authRepository.login(params);
  }
}

// 2. Data Layer - Repository Implementation
@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final ApiService _apiService;
  
  AuthRepositoryImpl(this._apiService);
  
  @override
  ResultFuture<LoginEntity> login(LoginCredentials credentials) {
    return guardDio<LoginEntity>(() async {
      final request = LoginRequest(
        username: credentials.username,
        password: credentials.password,
      );
      final dto = await _apiService.login(request);
      return dto.toEntity();
    });
  }
}

// 3. Data Layer - API Service
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;
  
  @POST('/auth/login')
  Future<LoginDto> login(@Body() LoginRequest request);
}

// 4. Presentation Layer - BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _loginUsecase;
  final ILocalStorage _localStorage;
  
  LoginBloc(this._loginUsecase, this._localStorage) : super(LoginState.initial()) {
    on<LoginRequested>(_onLoginRequested);
  }
  
  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());
    
    final result = await _loginUsecase(LoginCredentials(
      username: event.username,
      password: event.password,
    ));
    
    result.fold(
      (failure) => emit(LoginState.error(failure.message)),
      (user) async {
        await _localStorage.setAccessToken(user.accessToken);
        emit(LoginState.success(user));
      },
    );
  }
}

// 5. Presentation Layer - UI
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        getIt<LoginUserUsecase>(),
        getIt<ILocalStorage>(),
      ),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return state.when(
            initial: () => LoginForm(),
            loading: () => LoadingIndicator(),
            success: (user) => HomePage(user: user),
            error: (message) => ErrorMessage(message: message),
          );
        },
      ),
    );
  }
}
```

### Environment Configuration

```dart
// Environment setup
@module
abstract class EnvModule {
  @dev
  @singleton
  AppConfig devConfig() => AppConfig(
    flavor: Flavor.dev,
    baseUrl: 'https://dummyjson.com',
  );
  
  @staging
  @singleton
  AppConfig stagingConfig() => AppConfig(
    flavor: Flavor.staging,
    baseUrl: 'https://dummyjson.staging.com',
  );
  
  @prod
  @singleton
  AppConfig prodConfig() => AppConfig(
    flavor: Flavor.prod,
    baseUrl: 'https://dummyjson.prod.com',
  );
}

// Main entry points
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: 'dev');
  runApp(MyApp());
}
```

This tech stack provides a robust, scalable, and maintainable foundation for enterprise-level Flutter applications, with clear separation of concerns, comprehensive error handling, and excellent developer experience.
