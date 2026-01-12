import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class SettingTile extends StatelessWidget {
  final SvgGenImage icon;
  final String title;
  final VoidCallback? onTap;

  const SettingTile({super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: icon.svg(width: 20, height: 20),
          title: AppText(
            text: title,
            style: AppTextstyle.tsSemiboldSize16.copyWith(
              color: AppColors.darkText,
            ),
            textAlign: TextAlign.start,
          ),
          trailing: const Icon(Icons.chevron_right, color: AppColors.darkText),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}