/// Enum representing different application flavors/environments.
///
/// This enum defines the various deployment environments that the application
/// can run in, allowing for different configurations and behaviors based on
/// the current flavor.
///
/// Available flavors:
/// - [dev]: Development environment for local testing and debugging
/// - [staging]: Staging environment for pre-production testing
/// - [prod]: Production environment for live application deployment
enum Flavor { dev, staging, prod }
