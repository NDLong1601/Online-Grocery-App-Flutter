/// Defines the visual style variants for buttons in the application.
///
/// This enum provides different styling options that can be applied to buttons
/// to create consistent visual hierarchy and user interface patterns.
///
/// Available styles:
/// - [normal]: Standard filled button with background color
/// - [outline]: Button with transparent background and colored border
/// - [text]: Minimalist button with no background or border, text only
enum AppButtonVariant {
  /// Nút xanh (Please Try Again, Go to Checkout)
  primary,

  /// Nút nền trong suốt + viền (ảnh thứ 2)
  outline,

  /// Nút nền xám nhạt (Log Out)
  soft,

  /// Nút social (Google/Facebook)
  social,

}
