import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class ExpandableHeader extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget? trailing;

  const ExpandableHeader({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextstyle.tsSemiboldSize16.copyWith(
                color: AppColors.darkText,
              ),
            ),
            Row(
              children: [
                if (trailing != null) ...[
                  trailing!,
                  SizedBox(width: AppPadding.p8),
                ],
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: AppColors.darkText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
