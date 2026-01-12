import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class AppActionTile extends StatelessWidget {
  /// Left title
  final String title;

  /// Optional subtitle under title (nếu cần)
  final String? subtitle;

  /// Leading widget (icon/avatar...)
  final Widget? leading;

  /// Right value text (ví dụ: "Select Method", "$13.97")
  final String? value;

  /// Right custom widget (ví dụ: payment icon)
  final Widget? valueWidget;

  /// Show chevron icon at right
  final bool showChevron;

  /// Divider bottom
  final bool showDivider;

  /// Padding inside tile
  final EdgeInsetsGeometry padding;

  /// On tap
  final VoidCallback? onTap;

  /// Styling
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? valueStyle;
  final bool isBoldValue;

  /// Leading size constraint (giữ layout giống nhau)
  final double leadingSize;

  const AppActionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.value,
    this.valueWidget,
    this.showChevron = true,
    this.showDivider = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    this.onTap,
    this.titleStyle,
    this.subtitleStyle,
    this.valueStyle,
    this.isBoldValue = false,
    this.leadingSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final tStyle =
        titleStyle ??
        AppTextstyle.tsSemiboldSize16.copyWith(color: AppColors.darkText);

    final sStyle =
        subtitleStyle ??
        AppTextstyle.tsRegularSize14.copyWith(color: AppColors.grayText);

    final vStyle =
        valueStyle ??
        (isBoldValue
                ? AppTextstyle.tsSemiboldSize16
                : AppTextstyle.tsSemiboldSize16)
            .copyWith(color: AppColors.darkText);

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                if (leading != null) ...[
                  SizedBox(
                    width: leadingSize,
                    height: leadingSize,
                    child: FittedBox(fit: BoxFit.contain, child: leading),
                  ),
                  const SizedBox(width: 12),
                ],

                // Title + (optional subtitle)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: title,
                        style: tStyle,
                        textAlign: TextAlign.start,
                      ),
                      if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                        const SizedBox(height: 4),
                        AppText(
                          text: subtitle!,
                          style: sStyle,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ],
                  ),
                ),

                if (valueWidget != null) valueWidget!,
                if (value != null && value!.trim().isNotEmpty) ...[
                  if (valueWidget != null) const SizedBox(width: 8),
                  AppText(text: value!, style: vStyle),
                ],

                if (showChevron) ...[
                  const SizedBox(width: 10),
                  const Icon(Icons.chevron_right, color: AppColors.darkText),
                ],
              ],
            ),
          ),
        ),
        if (showDivider) const Divider(height: 1, color: Color(0xFFE2E2E2)),
      ],
    );
  }
}
