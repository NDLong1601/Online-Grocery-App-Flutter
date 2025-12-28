/// Enumeration representing the available application theme options.
///
/// This enum defines the different theme modes that the application can use:
/// - [light]: Forces the app to use light theme regardless of system settings
/// - [dark]: Forces the app to use dark theme regardless of system settings
/// - [system]: Uses the system's current theme setting (light or dark)
///
/// The system option allows the app to automatically adapt to the user's
/// device theme preferences and respond to theme changes dynamically.
/// App themes
enum AppTheme { light, dark, system }
