# 🚀 Setup & Usage Guide

This comprehensive guide will walk you through setting up, running, and working with the Online Grocery Store App project. Whether you're a beginner or experienced developer, this guide covers everything you need to know.

## 📋 Table of Contents

- [🔧 Prerequisites](#-prerequisites)
- [⚡ Quick Start](#-quick-start)
- [🛠️ Detailed Setup](#️-detailed-setup)
- [🌍 Environment Configuration](#-environment-configuration)
- [🏗️ Code Generation](#️-code-generation)
- [🚀 Running the App](#-running-the-app)
- [🧪 Testing](#-testing)
- [📱 Building for Production](#-building-for-production)
- [🔍 Debugging](#-debugging)
- [🛠️ Development Workflow](#️-development-workflow)
- [❗ Troubleshooting](#-troubleshooting)

## 🔧 Prerequisites

### System Requirements

#### Flutter SDK
- **Version**: 3.8.1 or higher
- **Channel**: Stable (recommended)

**Installation**:
```bash
# Check current Flutter version
flutter --version

# Upgrade Flutter if needed
flutter upgrade

# Verify installation
flutter doctor
```

#### Dart SDK
- **Version**: 3.8.1 or higher (comes with Flutter)

#### Development Environment

**Required IDEs** (choose one):
- **VS Code** (recommended) with Flutter extension
- **Android Studio** with Flutter plugin
- **IntelliJ IDEA** with Flutter plugin

**VS Code Extensions** (recommended):
```
- Flutter (Dart-Code.flutter)
- Dart (Dart-Code.dart-code)
- Bracket Pair Colorizer 2
- GitLens
- Error Lens
```

#### Platform-Specific Requirements

**For Android Development**:
- Android Studio or Android SDK
- Android SDK Platform-Tools
- Android SDK Build-Tools
- Java JDK 8 or higher

**For iOS Development** (macOS only):
- Xcode 12.0 or higher
- iOS Simulator
- CocoaPods

**Verification**:
```bash
flutter doctor -v
```

### Git
- **Version**: 2.0 or higher
- Configure with your credentials:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## ⚡ Quick Start

For experienced developers who want to get started immediately:

```bash
# 1. Clone the repository
git clone <repository-url>
cd Online-Grocery-App-Flutter

# 2. Install dependencies
flutter pub get

# 3. Generate code
dart run build_runner build --delete-conflicting-outputs

# 4. Run development version
flutter run --flavor dev -t lib/main_dev.dart
```

## 🛠️ Detailed Setup

### Step 1: Clone the Repository

```bash
# Clone via HTTPS
git clone https://github.com/your-username/Online-Grocery-App-Flutter.git

# Or clone via SSH (if you have SSH keys set up)
git clone git@github.com:your-username/Online-Grocery-App-Flutter.git

# Navigate to project directory
cd Online-Grocery-App-Flutter
```

### Step 2: Verify Flutter Installation

```bash
# Check Flutter installation
flutter doctor

# Expected output should show:
# ✓ Flutter (Channel stable, 3.8.1, on macOS/Windows/Linux)
# ✓ Android toolchain - develop for Android devices
# ✓ Xcode - develop for iOS and macOS (macOS only)
# ✓ Chrome - develop for the web
# ✓ Android Studio / VS Code
```

### Step 3: Install Dependencies

```bash
# Install Flutter dependencies
flutter pub get

# Verify dependencies are installed
flutter pub deps
```

**What this does**:
- Downloads all packages listed in `pubspec.yaml`
- Creates `pubspec.lock` file with exact versions
- Sets up the `.dart_tool` directory

### Step 4: IDE Setup

#### VS Code Setup

1. **Install Extensions**:
   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X)
   - Install "Flutter" extension (includes Dart)

2. **Configure Settings**:
   Create `.vscode/settings.json`:
   ```json
   {
     "dart.flutterSdkPath": "/path/to/flutter",
     "dart.lineLength": 120,
     "dart.insertArgumentPlaceholders": false,
     "editor.rulers": [80, 120],
     "editor.formatOnSave": true
   }
   ```

3. **Launch Configurations**:
   The project includes `.vscode/launch.json` with pre-configured launch options.

#### Android Studio Setup

1. **Install Flutter Plugin**:
   - File → Settings → Plugins
   - Search for "Flutter" and install
   - Restart Android Studio

2. **Configure Flutter SDK**:
   - File → Settings → Languages & Frameworks → Flutter
   - Set Flutter SDK path

### Step 5: Platform Setup

#### Android Setup

1. **Accept Android Licenses**:
   ```bash
   flutter doctor --android-licenses
   ```

2. **Create Android Emulator** (optional):
   ```bash
   # List available AVDs
   flutter emulators
   
   # Create new emulator
   flutter emulators --create --name pixel_4
   
   # Launch emulator
   flutter emulators --launch pixel_4
   ```

#### iOS Setup (macOS only)

1. **Install CocoaPods**:
   ```bash
   sudo gem install cocoapods
   ```

2. **Setup iOS Simulator**:
   ```bash
   # Open iOS Simulator
   open -a Simulator
   
   # List available simulators
   xcrun simctl list devices
   ```

## 🌍 Environment Configuration

The project supports three environments with different configurations:

### Environment Files Structure

```
lib/
├── main_dev.dart      # Development environment
├── main_staging.dart  # Staging environment
├── main_prod.dart     # Production environment
└── di/
    └── env_module.dart # Environment configurations
```

### Development Environment

**File**: `lib/main_dev.dart`
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: 'dev');
  runApp(const MyApp());
}
```

**Configuration**:
- Base URL: `https://dummyjson.com`
- Debug mode: Enabled
- Logging: Verbose
- API timeout: 30 seconds

### Staging Environment

**File**: `lib/main_staging.dart`
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: 'staging');
  runApp(const MyApp());
}
```

**Configuration**:
- Base URL: `https://dummyjson.staging.com`
- Debug mode: Limited
- Logging: Info level
- API timeout: 15 seconds

### Production Environment

**File**: `lib/main_prod.dart`
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: 'prod');
  runApp(const MyApp());
}
```

**Configuration**:
- Base URL: `https://dummyjson.prod.com`
- Debug mode: Disabled
- Logging: Error only
- API timeout: 10 seconds

### Custom Environment Variables

To add custom environment variables:

1. **Update `AppConfig`**:
   ```dart
   class AppConfig {
     final Flavor flavor;
     final String baseUrl;
     final String apiKey;        // New variable
     final bool enableAnalytics; // New variable
     
     AppConfig({
       required this.flavor,
       required this.baseUrl,
       required this.apiKey,
       required this.enableAnalytics,
     });
   }
   ```

2. **Update `EnvModule`**:
   ```dart
   @dev
   @singleton
   AppConfig devConfig() => AppConfig(
     flavor: Flavor.dev,
     baseUrl: 'https://dummyjson.com',
     apiKey: 'dev-api-key',
     enableAnalytics: false,
   );
   ```

## 🏗️ Code Generation

The project uses several code generators that need to be run when making changes:

### Available Generators

1. **Injectable** - Dependency injection
2. **Retrofit** - API client generation
3. **JSON Serializable** - Model serialization
4. **Freezed** - Immutable classes
5. **Flutter Gen** - Asset generation

### Running Code Generation

#### One-time Generation
```bash
# Generate all code
dart run build_runner build

# Force regeneration (cleans previous generated files)
dart run build_runner build --delete-conflicting-outputs
```

#### Watch Mode (Development)
```bash
# Watch for changes and regenerate automatically
dart run build_runner watch

# Watch with deletion of conflicting outputs
dart run build_runner watch --delete-conflicting-outputs
```

#### Specific Generators
```bash
# Only generate dependency injection
dart run build_runner build --build-filter="lib/di/injector.config.dart"

# Only generate API clients
dart run build_runner build --build-filter="lib/data/datasources/remote/*.g.dart"
```

### When to Run Code Generation

**Must run after**:
- Adding new `@injectable` classes
- Modifying API service methods
- Adding/modifying model classes with `@JsonSerializable`
- Adding new assets to `assets/` folder
- Creating new `@freezed` classes

**Example workflow**:
```bash
# 1. Make changes to code
# 2. Run generation
dart run build_runner build --delete-conflicting-outputs
# 3. Verify no errors
flutter analyze
# 4. Test your changes
flutter test
```

## 🚀 Running the App

### Command Line

#### Development Environment
```bash
# Run on connected device/emulator
flutter run --flavor dev -t lib/main_dev.dart

# Run on specific device
flutter run --flavor dev -t lib/main_dev.dart -d <device-id>

# Run with hot reload enabled (default)
flutter run --flavor dev -t lib/main_dev.dart --hot

# Run in debug mode with verbose logging
flutter run --flavor dev -t lib/main_dev.dart --verbose
```

#### Staging Environment
```bash
flutter run --flavor staging -t lib/main_staging.dart
```

#### Production Environment
```bash
flutter run --flavor prod -t lib/main_prod.dart --release
```

### IDE Integration

#### VS Code

1. **Using Launch Configurations**:
   - Press `F5` or go to Run → Start Debugging
   - Select environment from dropdown:
     - "Development"
     - "Staging" 
     - "Production"

2. **Using Command Palette**:
   - Press `Ctrl+Shift+P` (Cmd+Shift+P on Mac)
   - Type "Flutter: Select Device"
   - Choose your target device
   - Press `F5` to run

#### Android Studio

1. **Configure Run Configuration**:
   - Run → Edit Configurations
   - Add new Flutter configuration
   - Set Dart entrypoint: `lib/main_dev.dart`
   - Set additional arguments: `--flavor dev`

2. **Run**:
   - Click the green play button
   - Or press `Shift+F10`

### Device Selection

#### List Available Devices
```bash
flutter devices
```

#### Run on Specific Device
```bash
# Run on Android emulator
flutter run --flavor dev -t lib/main_dev.dart -d emulator-5554

# Run on iOS simulator
flutter run --flavor dev -t lib/main_dev.dart -d "iPhone 14 Pro"

# Run on physical device
flutter run --flavor dev -t lib/main_dev.dart -d "John's iPhone"

# Run on Chrome (web)
flutter run --flavor dev -t lib/main_dev.dart -d chrome
```

### Hot Reload & Hot Restart

**Hot Reload** (preserves app state):
- Press `r` in terminal
- Or save file in IDE with hot reload enabled

**Hot Restart** (resets app state):
- Press `R` in terminal
- Or use IDE restart button

**When to use Hot Restart**:
- After code generation
- When adding new dependencies
- When modifying main() function
- When changing app initialization code

## 🧪 Testing

### Running Tests

#### All Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run tests in verbose mode
flutter test --verbose
```

#### Specific Test Files
```bash
# Run specific test file
flutter test test/unit/domain/usecase/login_user_usecase_test.dart

# Run tests in specific directory
flutter test test/unit/

# Run widget tests only
flutter test test/widget/
```

#### Integration Tests
```bash
# Run integration tests
flutter drive --target=test_driver/app.dart

# Run on specific device
flutter drive --target=test_driver/app.dart -d <device-id>
```

### Test Coverage

#### Generate Coverage Report
```bash
# Run tests with coverage
flutter test --coverage

# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open coverage report
open coverage/html/index.html
```

#### Coverage Tools Setup

**Install lcov** (for HTML reports):
```bash
# macOS
brew install lcov

# Ubuntu/Debian
sudo apt-get install lcov

# Windows (using Chocolatey)
choco install lcov
```

### Test Structure

```
test/
├── unit/                    # Unit tests
│   ├── domain/
│   │   ├── entities/
│   │   ├── usecase/
│   │   └── value_object/
│   ├── data/
│   │   ├── datasources/
│   │   ├── models/
│   │   └── repositories/
│   └── presentation/
│       └── bloc/
├── widget/                  # Widget tests
│   └── screens/
├── integration/             # Integration tests
│   └── flows/
├── mocks/                   # Mock objects
└── test_utils/              # Test utilities
```

### Writing Tests

#### Unit Test Example
```dart
// test/unit/domain/usecase/login_user_usecase_test.dart
void main() {
  group('LoginUserUsecase', () {
    late LoginUserUsecase usecase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      usecase = LoginUserUsecase(mockRepository);
    });

    test('should return LoginEntity when login is successful', () async {
      // Arrange
      final credentials = LoginCredentials(username: 'test', password: 'test');
      final expectedEntity = LoginEntity(id: 1, username: 'test');
      
      when(() => mockRepository.login(credentials))
          .thenAnswer((_) async => Right(expectedEntity));

      // Act
      final result = await usecase(credentials);

      // Assert
      expect(result, Right(expectedEntity));
      verify(() => mockRepository.login(credentials)).called(1);
    });
  });
}
```

#### Widget Test Example
```dart
// test/widget/screens/login_screen_test.dart
void main() {
  group('LoginScreen', () {
    testWidgets('should display login form', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Assert
      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
```

## 📱 Building for Production

### Android Build

#### APK Build
```bash
# Build APK for all architectures
flutter build apk --flavor prod -t lib/main_prod.dart

# Build APK for specific architecture
flutter build apk --flavor prod -t lib/main_prod.dart --target-platform android-arm64

# Build APK with obfuscation
flutter build apk --flavor prod -t lib/main_prod.dart --obfuscate --split-debug-info=build/debug-info/
```

#### App Bundle Build (Recommended for Play Store)
```bash
# Build App Bundle
flutter build appbundle --flavor prod -t lib/main_prod.dart

# Build with obfuscation
flutter build appbundle --flavor prod -t lib/main_prod.dart --obfuscate --split-debug-info=build/debug-info/
```

### iOS Build

#### IPA Build
```bash
# Build for iOS
flutter build ios --flavor prod -t lib/main_prod.dart --release

# Build IPA (requires Xcode configuration)
flutter build ipa --flavor prod -t lib/main_prod.dart
```

#### Xcode Build
```bash
# Open iOS project in Xcode
open ios/Runner.xcworkspace

# Then build and archive in Xcode
```

### Web Build

```bash
# Build for web
flutter build web --flavor prod -t lib/main_prod.dart

# Build with specific base href
flutter build web --flavor prod -t lib/main_prod.dart --base-href /app/

# Build with PWA support
flutter build web --flavor prod -t lib/main_prod.dart --pwa-strategy offline-first
```

### Build Optimization

#### Code Obfuscation
```bash
# Build with obfuscation (recommended for production)
flutter build apk --flavor prod -t lib/main_prod.dart \
  --obfuscate \
  --split-debug-info=build/debug-info/

# Keep debug symbols for crash reporting
flutter build apk --flavor prod -t lib/main_prod.dart \
  --obfuscate \
  --split-debug-info=build/debug-info/ \
  --dart-define=FLUTTER_WEB_USE_SKIA=true
```

#### Size Analysis
```bash
# Analyze APK size
flutter build apk --flavor prod -t lib/main_prod.dart --analyze-size

# Generate size analysis report
flutter build apk --flavor prod -t lib/main_prod.dart --analyze-size --target-platform android-arm64
```

## 🔍 Debugging

### Debug Tools

#### Flutter Inspector
```bash
# Launch Flutter Inspector
flutter inspector

# Or use in IDE:
# VS Code: Ctrl+Shift+P → "Flutter: Open Flutter Inspector"
# Android Studio: View → Tool Windows → Flutter Inspector
```

#### Performance Profiling
```bash
# Run with performance overlay
flutter run --flavor dev -t lib/main_dev.dart --enable-software-rendering

# Profile app performance
flutter drive --target=test_driver/perf_test.dart --profile
```

### Logging and Debugging

#### Console Logging
The app includes comprehensive logging. View logs in:

**VS Code**: Debug Console panel
**Android Studio**: Run/Debug panel
**Terminal**: Logs appear in the terminal where you ran `flutter run`

#### Log Levels
- **Trace**: Detailed execution flow
- **Debug**: Debug information
- **Info**: General information
- **Warning**: Warning messages
- **Error**: Error messages
- **Fatal**: Critical errors

#### Custom Logging
```dart
// Inject logger
final logger = getIt<AppLogger>();

// Use in your code
logger.i('User logged in', metadata: {'userId': user.id});
logger.e('Login failed', error: exception, stackTrace: stackTrace);
```

### Common Debug Scenarios

#### Network Issues
```bash
# Enable network logging
flutter run --flavor dev -t lib/main_dev.dart --verbose

# Check network interceptor logs in console
```

#### State Management Issues
```bash
# Enable BLoC observer for state debugging
# Logs will show state transitions in console
```

#### Performance Issues
```bash
# Run with performance overlay
flutter run --flavor dev -t lib/main_dev.dart --enable-software-rendering

# Check for:
# - Frame rendering times
# - Memory usage
# - CPU usage
```

## 🛠️ Development Workflow

### Daily Development

1. **Start Development Session**:
   ```bash
   # Pull latest changes
   git pull origin main
   
   # Install any new dependencies
   flutter pub get
   
   # Generate code if needed
   dart run build_runner build --delete-conflicting-outputs
   
   # Start development server
   flutter run --flavor dev -t lib/main_dev.dart
   ```

2. **During Development**:
   - Use hot reload for UI changes
   - Use hot restart for logic changes
   - Run tests frequently: `flutter test`
   - Check code quality: `flutter analyze`

3. **Before Committing**:
   ```bash
   # Format code
   dart format .
   
   # Analyze code
   flutter analyze
   
   # Run tests
   flutter test
   
   # Generate code
   dart run build_runner build --delete-conflicting-outputs
   ```

### Adding New Features

1. **Create Feature Branch**:
   ```bash
   git checkout -b feature/new-feature-name
   ```

2. **Follow Clean Architecture**:
   - Add domain entities/use cases first
   - Implement data layer (repositories, data sources)
   - Create presentation layer (BLoC, UI)
   - Add dependency injection
   - Write tests

3. **Code Generation**:
   ```bash
   # After adding new models, APIs, or injectable classes
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Testing**:
   ```bash
   # Test your feature
   flutter test test/unit/domain/usecase/your_usecase_test.dart
   flutter test test/widget/screens/your_screen_test.dart
   ```

### Code Quality Checks

#### Automated Checks
```bash
# Run all quality checks
./scripts/quality_check.sh

# Or manually:
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

#### Pre-commit Hooks
Set up pre-commit hooks to run quality checks:

```bash
# .git/hooks/pre-commit
#!/bin/sh
dart format --set-exit-if-changed .
flutter analyze
flutter test --no-pub
```

## ❗ Troubleshooting

### Common Issues

#### 1. "Target of URI doesn't exist" Error

**Problem**: Generated files not found
**Solution**:
```bash
dart run build_runner build --delete-conflicting-outputs
```

#### 2. Dependency Injection Errors

**Problem**: `GetIt` can't find registered dependencies
**Solutions**:
```bash
# Regenerate DI code
dart run build_runner build --delete-conflicting-outputs

# Check if service is properly annotated with @injectable
# Verify module is imported in injector.dart
```

#### 3. Flutter Doctor Issues

**Problem**: `flutter doctor` shows errors
**Solutions**:
```bash
# Accept Android licenses
flutter doctor --android-licenses

# Update Flutter
flutter upgrade

# Clean and reinstall
flutter clean
flutter pub get
```

#### 4. Build Failures

**Problem**: Build fails with various errors
**Solutions**:
```bash
# Clean build cache
flutter clean

# Delete generated files and regenerate
rm -rf .dart_tool/build
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs

# Reinstall dependencies
flutter pub get
```

#### 5. Hot Reload Not Working

**Problem**: Changes not reflecting in app
**Solutions**:
- Use Hot Restart (`R` in terminal)
- Restart the app completely
- Check if you modified main() function (requires restart)
- Verify you're not in release mode

#### 6. iOS Build Issues

**Problem**: iOS build fails
**Solutions**:
```bash
# Clean iOS build
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..

# Update CocoaPods
sudo gem install cocoapods

# Clean Flutter
flutter clean
flutter pub get
```

#### 7. Android Build Issues

**Problem**: Android build fails
**Solutions**:
```bash
# Clean Android build
cd android
./gradlew clean
cd ..

# Update Gradle wrapper
cd android
./gradlew wrapper --gradle-version 7.6
cd ..

# Accept licenses
flutter doctor --android-licenses
```

### Performance Issues

#### 1. Slow Build Times

**Solutions**:
```bash
# Use build cache
export FLUTTER_BUILD_CACHE=true

# Increase Gradle memory
# In android/gradle.properties:
org.gradle.jvmargs=-Xmx4g -XX:MaxPermSize=512m

# Use incremental builds
dart run build_runner build --incremental
```

#### 2. Large App Size

**Solutions**:
```bash
# Build with obfuscation
flutter build apk --obfuscate --split-debug-info=build/debug-info/

# Analyze size
flutter build apk --analyze-size

# Use app bundles instead of APK
flutter build appbundle
```

### Getting Help

#### 1. Check Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- Project README files

#### 2. Community Resources
- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Discord](https://discord.gg/flutter)

#### 3. Debug Information
When asking for help, provide:
```bash
# Flutter version
flutter --version

# Doctor output
flutter doctor -v

# Dependency tree
flutter pub deps

# Error logs with full stack trace
```

---

This guide should help you get up and running with the project quickly and efficiently. For more specific questions about the architecture or implementation details, refer to the other documentation files in this repository.
