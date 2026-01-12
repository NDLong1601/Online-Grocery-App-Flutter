import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';
import 'package:online_groceries_store_app/presentation/screens/account/account_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/cart/cart_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/explore/explore_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/favourite/favourite_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/shop/shop_screen.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class BottomTab extends StatefulWidget {
  final LoginEntity user;

  const BottomTab({super.key, required this.user});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int currentIndex = 0;

  Color _iconColor(int index) {
    return currentIndex == index ? AppColors.greenAccent : AppColors.darkText;
  }

  BottomNavigationBarItem _buildItem({
    required int index,
    required SvgGenImage icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: icon.svg(
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(_iconColor(index), BlendMode.srcIn),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(
        index: currentIndex,
        children: [
          const ShopScreen(),
          const ExploreScreen(),
          CartScreen(userId: widget.user.id),
          const FavouriteScreen(),
          AccountScreen(user: widget.user),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.greenAccent,
        unselectedItemColor: AppColors.darkText,
        showUnselectedLabels: true,
        selectedLabelStyle: AppTextstyle.tsSemiboldSize12,
        unselectedLabelStyle: AppTextstyle.tsSemiboldSize12,
        items: [
          _buildItem(index: 0, icon: Assets.icons.icShop, label: 'Shop'),
          _buildItem(index: 1, icon: Assets.icons.icExplore, label: 'Explore'),
          _buildItem(index: 2, icon: Assets.icons.icCart, label: 'Cart'),
          _buildItem(
            index: 3,
            icon: Assets.icons.icFavourite,
            label: 'Favourite',
          ),
          _buildItem(index: 4, icon: Assets.icons.icAccount, label: 'Account'),
        ],

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
