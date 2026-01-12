import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/enums/button_style.dart';
import 'package:online_groceries_store_app/presentation/screens/account/widget/setting_tile.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';

class AccountScreen extends StatelessWidget {
  final LoginEntity user;

  const AccountScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final fullName = '${user.firstName} ${user.lastName}'.trim();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
                vertical: AppPadding.p16,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundImage: NetworkImage(user.image),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                fullName.isEmpty ? user.username : fullName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextstyle.tsRegularSize20.copyWith(
                                  color: AppColors.darkText,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.edit,
                              size: 18,
                              color: AppColors.greenAccent,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextstyle.tsRegularSize16.copyWith(
                            color: AppColors.grayText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Menu list
            Expanded(
              child: ListView(
                children: [
                  SettingTile(
                    title: 'Orders',
                    icon: Assets.icons.icOrders,
                    onTap: () {},
                  ),
                  SettingTile(
                    title: 'My details',
                    icon: Assets.icons.icDetail,
                    onTap: () {},
                  ),
                  SettingTile(
                    title: 'Delivery Address',
                    icon: Assets.icons.icAddress,
                    onTap: () {},
                  ),
                  SettingTile(
                    title: 'Payment Methods',
                    icon: Assets.icons.icPayment,
                    onTap: () {},
                  ),
                  SettingTile(
                    title: 'Promo Card',
                    icon: Assets.icons.icPromo,
                    onTap: () {},
                  ),
                  SettingTile(
                    title: 'Notifecations',
                    icon: Assets.icons.icNotifications,
                    onTap: () {},
                  ),
                  SettingTile(
                    title: 'Help',
                    icon: Assets.icons.icHelp,
                    onTap: () {},
                  ),
                  SettingTile(
                    title: 'About',
                    icon: Assets.icons.icAbout,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Logout button
            Padding(
              padding: const EdgeInsets.all(25),
              child: AppButton(
                text: 'Log Out',
                onPressed: () => context.goNamed(RouteName.loginName),
                variant: AppButtonVariant.soft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
