import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/core/enums/textfield_style.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.variant = AppTextFieldVariant.underline,

    // Text
    this.labelText,
    this.hintText,
    this.controller,
    this.focusNode,
    this.initialValue,

    // Input behavior
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autofillHints,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.textCapitalization = TextCapitalization.none,

    // Obscure / password
    this.obscureText = false,
    this.enableObscureToggle = false,

    // Leading / trailing
    this.leading,
    this.trailing,
    this.onTapTrailing,

    // Styling overrides (để mở rộng sau này)
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.contentPadding,
  });

  final AppTextFieldVariant variant;

  // Text
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;

  // Input behavior
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final TextCapitalization textCapitalization;

  // Obscure / password
  final bool obscureText;
  final bool enableObscureToggle;

  /// Leading widget (icon search, flag + code, ...)
  final Widget? leading;

  /// Trailing widget (icon clear, filter, ...)
  final Widget? trailing;

  /// Optional action for trailing (nếu trailing là icon dạng button)
  final VoidCallback? onTapTrailing;

  // Styling overrides
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Nếu parent đổi obscureText, sync lại
    if (oldWidget.obscureText != widget.obscureText) {
      _obscure = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? 14.0;

    final borderColor =
        widget.borderColor ?? AppColors.grayText.withValues(alpha: 0.25);
    final focusedBorderColor =
        widget.focusedBorderColor ?? AppColors.primaryColor;

    final fillColor =
        widget.fillColor ??
        (widget.variant == AppTextFieldVariant.search
            ? const Color(0xFFF2F3F2) // giống search field trong hình
            : Colors.transparent);

    final hintStyle = AppTextstyle.tsRegularSize14.copyWith(
      color: AppColors.grayText,
    );

    final inputStyle = AppTextstyle.tsRegularSize16.copyWith(
      color: AppColors.darkText,
    );

    final labelStyle = AppTextstyle.tsRegularSize14.copyWith(
      color: AppColors.grayText,
    );

    InputBorder enabledBorder;
    InputBorder focusedBorder;

    switch (widget.variant) {
      case AppTextFieldVariant.underline:
        enabledBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1),
        );
        focusedBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
        );
        break;

      case AppTextFieldVariant.filled:
        enabledBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor, width: 1),
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
        );
        break;

      case AppTextFieldVariant.search:
        enabledBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        );
        break;
    }

    final defaultPadding = widget.variant == AppTextFieldVariant.underline
        ? const EdgeInsets.symmetric(vertical: 14)
        : const EdgeInsets.symmetric(vertical: 14, horizontal: AppPadding.p16);

    final suffix = _buildSuffix();

    final field = TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      initialValue: widget.controller == null ? widget.initialValue : null,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      autofillHints: widget.autofillHints,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      textCapitalization: widget.textCapitalization,
      obscureText: _obscure,
      style: inputStyle,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        filled: widget.variant != AppTextFieldVariant.underline,
        fillColor: fillColor,

        hintText: widget.hintText,
        hintStyle: hintStyle,

        border: enabledBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,

        contentPadding: widget.contentPadding ?? defaultPadding,

        // Leading (search icon / flag+code...)
        prefixIcon: widget.leading == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16, right: 10),
                child: widget.leading,
              ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        // Suffix (password toggle / custom trailing)
        suffixIcon: suffix,
      ),
    );

    if (widget.labelText == null || widget.labelText!.trim().isEmpty) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText!, style: labelStyle),
        const SizedBox(height: 6),
        field,
      ],
    );
  }

  Widget? _buildSuffix() {
    // 1) Password toggle
    if (widget.enableObscureToggle) {
      return IconButton(
        onPressed: () => setState(() => _obscure = !_obscure),
        icon: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.grayText,
        ),
      );
    }

    // 2) Custom trailing
    if (widget.trailing != null) {
      if (widget.onTapTrailing != null) {
        return IconButton(
          onPressed: widget.onTapTrailing,
          icon: widget.trailing!,
        );
      }
      return Padding(
        padding: const EdgeInsets.only(right: AppPadding.p8),
        child: widget.trailing,
      );
    }

    return null;
  }
}

/// ==== Search Store ====
/// AppTextField(
//   variant: AppTextFieldVariant.search,
//   hintText: 'Search Store',
//   leading: Icon(Icons.search, color: AppColors.grayText),
//   onChanged: (value) {
//     // search...
//   },
// )

// ==== Phone code + flag +880 ====
// AppTextField(
//   variant: AppTextFieldVariant.underline,
//   keyboardType: TextInputType.phone,
//   hintText: 'Phone Number',
//   leading: Row(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       // Bạn thay bằng Image.asset / SvgPicture tuỳ project
//       const Text('🇧🇩', style: TextStyle(fontSize: 18)),
//       const SizedBox(width: 8),
//       Text('+880', style: AppTextstyle.tsRegularSize16),
//     ],
//   ),
// )

/// ==== Email / Password ====
// AppTextField(
//   variant: AppTextFieldVariant.underline,
//   labelText: 'Email',
//   hintText: 'imshuvo97@gmail.com',
//   keyboardType: TextInputType.emailAddress,
// );

// AppTextField(
//   variant: AppTextFieldVariant.underline,
//   labelText: 'Password',
//   hintText: '••••••••',
//   obscureText: true,
//   enableObscureToggle: true,
// );
