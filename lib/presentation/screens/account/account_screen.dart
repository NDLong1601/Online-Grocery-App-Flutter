import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/enums/button_style.dart';
import 'package:online_groceries_store_app/core/extensions/context_extension.dart';
import 'package:online_groceries_store_app/l10n/app_localizations.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_state.dart';
import 'package:online_groceries_store_app/presentation/shared/app_action_tile.dart';
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
                                user.fullName,
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
                  AppActionTile(
                    title: context.appLocalizations!.orders,
                    leading: Assets.icons.icOrders.svg(width: 20, height: 20),
                    onTap: () {},
                  ),
                  AppActionTile(
                    title: context.appLocalizations!.myDetails,
                    leading: Assets.icons.icDetail.svg(width: 20, height: 20),
                    onTap: () {},
                  ),
                  AppActionTile(
                    title: context.appLocalizations!.deliveryAddress,
                    leading: Assets.icons.icAddress.svg(width: 20, height: 20),
                    onTap: () {},
                  ),
                  AppActionTile(
                    title: context.appLocalizations!.paymentMethods,
                    leading: Assets.icons.icPayment.svg(width: 20, height: 20),
                    onTap: () {},
                  ),
                  AppActionTile(
                    title: context.appLocalizations!.promoCard,
                    leading: Assets.icons.icPromo.svg(width: 20, height: 20),
                    onTap: () {},
                  ),
                  AppActionTile(
                    title: context.appLocalizations!.notifications,
                    leading: Assets.icons.icNotifications.svg(
                      width: 20,
                      height: 20,
                    ),
                    onTap: () {},
                  ),
                  AppActionTile(
                    title: context.appLocalizations!.help,
                    leading: Assets.icons.icHelp.svg(width: 20, height: 20),
                    onTap: () {},
                  ),
                  AppActionTile(
                    title: context.appLocalizations!.about,
                    leading: Assets.icons.icAbout.svg(width: 20, height: 20),
                    onTap: () {},
                  ),
                  Row(
                    children: [
                      Text(
                        context.appLocalizations!.changeLanguage,
                        style: AppTextstyle.tsRegularSize16,
                      ),
                      const Spacer(),
                      BlocBuilder<LocaleBloc, LocaleState>(
                        builder: (context, state) {
                          final bool isEnglish = state.languageCode == 'en'
                              ? true
                              : false;
                          return Switch(
                            value: isEnglish,
                            onChanged: (value) {
                              context.read<LocaleBloc>().add(
                                OnChangeLocaleEvent(
                                  state.languageCode == 'en' ? 'vi' : 'en',
                                  state.countryCode == 'US' ? 'VN' : 'US',
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Logout button
            Padding(
              padding: const EdgeInsets.all(25),
              child: AppButton(
                text: context.appLocalizations!.logOut,
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
