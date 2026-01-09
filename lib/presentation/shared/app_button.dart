import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/core/enums/button_style.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,

    // Variant & sizing
    this.variant = AppButtonVariant.primary,
    this.height = 67,
    this.borderRadius = 18,
    this.fullWidth = true,

    // Content
    this.leading,
    this.trailing,
    this.gap = 12,

    // Checkout badge (giá)
    this.badgeText,
    this.badgeBackgroundColor,
    this.badgeTextColor,

    // Style overrides (để dùng về sau)
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.padding,

    // States
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;

  final AppButtonVariant variant;
  final double height;
  final double borderRadius;
  final bool fullWidth;

  final Widget? leading;
  final Widget? trailing;
  final double gap;

  /// Ví dụ: "$12.96" (nút Checkout)
  final String? badgeText;
  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  final bool isLoading;

  bool get _enabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    // Defaults theo variant
    final Color bg = backgroundColor ?? _defaultBackground();
    final Color fg = foregroundColor ?? _defaultForeground();
    final Color br = borderColor ?? _defaultBorder();

    final EdgeInsetsGeometry pad =
        padding ?? const EdgeInsets.symmetric(horizontal: AppPadding.p24);

    final ButtonStyle style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        Size(fullWidth ? double.infinity : 0, height),
      ),
      fixedSize: fullWidth
          ? null
          : WidgetStateProperty.all(Size.fromHeight(height)),
      padding: WidgetStateProperty.all(pad),
      elevation: WidgetStateProperty.all(0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: radius,
          side: variant == AppButtonVariant.outline
              ? BorderSide(color: br, width: 1.5)
              : BorderSide.none,
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (!_enabled) return bg.withValues(alpha: 0.5);
        return bg;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (!_enabled) return fg.withValues(alpha: 0.7);
        return fg;
      }),
      overlayColor: WidgetStateProperty.all(fg.withValues(alpha: 0.08)),
    );

    final child = _buildChild(fg);

    switch (variant) {
      case AppButtonVariant.outline:
        return OutlinedButton(
          onPressed: _enabled ? onPressed : null,
          style: style.copyWith(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
          ),
          child: child,
        );

      default:
        return ElevatedButton(
          onPressed: _enabled ? onPressed : null,
          style: style,
          child: child,
        );
    }
  }

  Widget _buildChild(Color fg) {
    final textWidget = AppText(
      text: text,
      style: AppTextstyle.tsSemiboldSize16.copyWith(color: fg),
      maxLines: 1,
    );

    if (isLoading) {
      return SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(strokeWidth: 2, color: fg),
      );
    }

    // Nút Checkout có badge giá: center text + badge ở phải
    if (badgeText != null && badgeText!.trim().isNotEmpty) {
      final badgeBg =
          badgeBackgroundColor ?? AppColors.primaryColor.withValues(alpha: 0.2);
      final badgeFg = badgeTextColor ?? fg;

      return Stack(
        alignment: Alignment.center,
        children: [
          Align(alignment: Alignment.center, child: textWidget),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badgeText!,
                style: AppTextstyle.tsSemiboldSize12.copyWith(color: badgeFg),
              ),
            ),
          ),
        ],
      );
    }

    // Bình thường: leading + text + trailing
    if (leading == null && trailing == null) return textWidget;

    return Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: fullWidth
          ? MainAxisAlignment.center
          : MainAxisAlignment.center,
      children: [
        if (leading != null) leading!,
        if (leading != null) SizedBox(width: gap),
        Flexible(child: textWidget),
        if (trailing != null) SizedBox(width: gap),
        if (trailing != null) trailing!,
      ],
    );
  }

  Color _defaultBackground() {
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.greenAccent;
      case AppButtonVariant.soft:
        return const Color(0xFFF2F3F2);
      case AppButtonVariant.social:
        return AppColors.blueAccent;
      case AppButtonVariant.outline:
        return Colors.transparent;
    }
  }

  Color _defaultForeground() {
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.social:
        return Colors.white;
      case AppButtonVariant.soft:
        return AppColors.greenAccent;
      case AppButtonVariant.outline:
        return AppColors.darkText;
    }
  }

  Color _defaultBorder() {
    switch (variant) {
      case AppButtonVariant.outline:
        return AppColors.purpleLight;
      default:
        return Colors.transparent;
    }
  }
}

/// Nút vuông bo góc cho + / -
class AppSquareIconButton extends StatelessWidget {
  const AppSquareIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 45,
    this.borderRadius = 16,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE2E2E2),
    this.iconColor,
    this.iconSize = 26,
    this.isEnabled = true,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  final double size;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;

  final Color? iconColor;
  final double iconSize;

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final enabled = isEnabled && onPressed != null;

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor, width: 1),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: enabled ? onPressed : null,
          child: Icon(
            icon,
            size: iconSize,
            color: (iconColor ?? AppColors.greenAccent).withValues(
              alpha: enabled ? 1 : 0.4,
            ),
          ),
        ),
      ),
    );
  }
}
