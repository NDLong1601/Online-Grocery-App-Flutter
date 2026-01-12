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
    this.autovalidateMode,

    // Obscure / password
    this.obscureText = false,
    this.enableObscureToggle = false,

    // Leading / trailing
    this.leading,
    this.trailing,
    this.onTapTrailing,

    // ✅ Check (dùng helper bên ngoài)
    this.enableCheck = false,
    this.checkValidator,
    this.showCheckWhenEmpty = false,
    this.checkIcon,

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
  final AutovalidateMode? autovalidateMode;

  // Obscure / password
  final bool obscureText;
  final bool enableObscureToggle;

  /// Leading widget (icon search, flag + code, ...)
  final Widget? leading;

  /// Trailing widget (icon clear, filter, ...)
  final Widget? trailing;

  /// Optional action for trailing (nếu trailing là icon dạng button)
  final VoidCallback? onTapTrailing;

  /// bật hiển thị icon check theo `checkValidator`
  final bool enableCheck;

  /// hàm check do bạn truyền từ helper: (text) => true/false
  final bool Function(String value)? checkValidator;

  /// nếu true: text rỗng vẫn cho phép check (thường để false)
  final bool showCheckWhenEmpty;

  /// icon check custom (mặc định Icons.check)
  final Widget? checkIcon;

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

  TextEditingController? _internalController;
  TextEditingController? _listeningController;

  bool _isValidForCheck = false;

  TextEditingController get _effectiveController {
    if (widget.controller != null) return widget.controller!;
    return _internalController ??= TextEditingController(
      text: widget.initialValue ?? '',
    );
  }

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;

    _attachListener();
    _recalcCheck();
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // sync obscure
    if (oldWidget.obscureText != widget.obscureText) {
      _obscure = widget.obscureText;
    }

    // controller changed => re-attach listener
    if (oldWidget.controller != widget.controller) {
      _detachListener(oldWidget.controller ?? _internalController);
      _attachListener();
      _recalcCheck();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _detachListener(_listeningController);
    _internalController?.dispose();
    super.dispose();
  }

  void _attachListener() {
    _listeningController = _effectiveController;
    _listeningController?.addListener(_handleTextChanged);
  }

  void _detachListener(TextEditingController? controller) {
    controller?.removeListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    final before = _isValidForCheck;
    _recalcCheck();

    if (before != _isValidForCheck) {
      setState(() {});
    }
  }

  void _recalcCheck() {
    if (!widget.enableCheck || widget.checkValidator == null) {
      _isValidForCheck = false;
      return;
    }

    final text = _effectiveController.text;

    if (text.trim().isEmpty && !widget.showCheckWhenEmpty) {
      _isValidForCheck = false;
      return;
    }

    _isValidForCheck = widget.checkValidator!(text);
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
            ? const Color(0xFFF2F3F2)
            : Colors.transparent);

    final hintStyle = AppTextstyle.tsRegularSize14.copyWith(
      color: AppColors.grayText,
    );

    final inputStyle = AppTextstyle.tsRegularSize16.copyWith(
      color: AppColors.darkText,
    );

    final labelStyle = AppTextstyle.tsSemiboldSize16.copyWith(
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
      controller: _effectiveController,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: (value) {
        widget.onChanged?.call(value);
        // update check realtime
        _handleTextChanged();
      },
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
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

        // Leading
        prefixIcon: widget.leading == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16, right: 10),
                child: widget.leading,
              ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        // Suffix
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
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
    final List<Widget> items = [];

    // 1) Password toggle
    if (widget.enableObscureToggle) {
      items.add(
        IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.grayText,
          ),
        ),
      );
    }

    // 2) Check icon (from helper)
    if (widget.enableCheck && widget.checkValidator != null && _isValidForCheck) {
      items.add(
        Padding(
          padding: const EdgeInsets.only(right: AppPadding.p8),
          child: widget.checkIcon ??
              Icon(Icons.check, color: AppColors.greenAccent),
        ),
      );
    }

    // 3) Custom trailing
    if (widget.trailing != null) {
      if (widget.onTapTrailing != null) {
        items.add(
          IconButton(
            onPressed: widget.onTapTrailing,
            icon: widget.trailing!,
          ),
        );
      } else {
        items.add(
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.p8),
            child: widget.trailing!,
          ),
        );
      }
    }

    if (items.isEmpty) return null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }
}
