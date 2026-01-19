import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/enums/textfield_style.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/entities/category_entity.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_categories_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_products_by_category_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/shop/shop_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/shop/shop_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/shop/shop_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/screens/category_detail/category_detail_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:online_groceries_store_app/presentation/shared/app_textfield.dart';
import 'package:online_groceries_store_app/presentation/shared/product_card_widget.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopBloc(
        getIt<GetCategoriesUsecase>(),
        getIt<GetProductsByCategoryUsecase>(),
        getIt<CreateCartUsecase>(),
        FailureMapper(context),
      )..add(const OnLoadShopDataEvent()),
      child: const _ShopView(),
    );
  }
}

class _ShopView extends StatefulWidget {
  const _ShopView();

  @override
  State<_ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<_ShopView> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;

  /// Banner images for the carousel
  final List<String> _bannerImages = [
    'assets/images/img_banner_1.png',
    'assets/images/img_frash_fruit_vegetable.png',
    'assets/images/img_meat_and_fish.png',
  ];

  @override
  void initState() {
    super.initState();
    _startBannerAutoScroll();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _bannerController.dispose();
    _bannerTimer?.cancel();
    super.dispose();
  }

  void _startBannerAutoScroll() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        final bloc = context.read<ShopBloc>();
        final currentIndex = bloc.state.currentBannerIndex;
        final nextIndex = (currentIndex + 1) % _bannerImages.length;

        _bannerController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        bloc.add(OnBannerPageChangedEvent(pageIndex: nextIndex));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocConsumer<ShopBloc, ShopState>(
          listener: _blocListener,
          builder: (context, state) {
            if (state.isLoading && state.categories.isEmpty) {
              return _buildLoadingWidget();
            }

            if (state.errorMessage.isNotEmpty && state.categories.isEmpty) {
              return _buildErrorWidget(state.errorMessage);
            }

            return _buildContent(state);
          },
        ),
      ),
    );
  }

  void _blocListener(BuildContext context, ShopState state) {
    if (state.addToCartSuccessMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.addToCartSuccessMessage!),
          backgroundColor: AppColors.greenAccent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
    if (state.addToCartErrorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.addToCartErrorMessage!),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.greenAccent),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            SizedBox(height: AppPadding.p16),
            Text(
              errorMessage,
              style: AppTextstyle.tsRegularSize14.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppPadding.p16),
            ElevatedButton(
              onPressed: () {
                context.read<ShopBloc>().add(const OnLoadShopDataEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenAccent,
              ),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ShopState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ShopBloc>().add(const OnRefreshShopDataEvent());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppPadding.p16),
            _buildHeader(),
            SizedBox(height: AppPadding.p16),
            _buildSearchField(),
            SizedBox(height: AppPadding.p16),
            _buildBannerCarousel(state),
            SizedBox(height: AppPadding.p24),
            ..._buildCategorySections(state),
            _buildGroceriesSection(state),
            SizedBox(height: AppPadding.p24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        children: [
          // Logo and Carrot Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/img_carot.png', width: 30, height: 30),
            ],
          ),
          SizedBox(height: AppPadding.p8),
          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: AppColors.darkText, size: 18),
              const SizedBox(width: 4),
              Text(
                'Dhaka, Banassre',
                style: AppTextstyle.tsRegularSize16.copyWith(
                  color: AppColors.darkText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: AppTextField(
        variant: AppTextFieldVariant.search,
        hintText: 'Search Store',
        controller: _searchController,
        leading: const Icon(Icons.search, color: AppColors.grayText),
      ),
    );
  }

  Widget _buildBannerCarousel(ShopState state) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) {
              context.read<ShopBloc>().add(
                OnBannerPageChangedEvent(pageIndex: index),
              );
            },
            itemCount: _bannerImages.length,
            itemBuilder: (context, index) {
              return _buildBannerItem(_bannerImages[index]);
            },
          ),
        ),
        SizedBox(height: AppPadding.p12),
        _buildBannerIndicator(state),
      ],
    );
  }

  Widget _buildBannerItem(String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.greenAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '🥬 Fresh Vegetables',
                      style: AppTextstyle.tsSemiboldSize18.copyWith(
                        color: AppColors.greenAccent,
                      ),
                    ),
                    SizedBox(height: AppPadding.p4),
                    Text(
                      'Get Up To 40% OFF',
                      style: AppTextstyle.tsRegularSize14.copyWith(
                        color: AppColors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBannerIndicator(ShopState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _bannerImages.length,
        (index) => Container(
          width: index == state.currentBannerIndex ? 16 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == state.currentBannerIndex
                ? AppColors.greenAccent
                : AppColors.grayText.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategorySections(ShopState state) {
    return state.categories.map((category) {
      return _buildCategorySection(category, state);
    }).toList();
  }

  Widget _buildCategorySection(CategoryEntity category, ShopState state) {
    final products = state.getProductsForCategory(category.slug);
    final isLoading = state.isCategoryLoading(category.slug);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(category),
        SizedBox(height: AppPadding.p12),
        isLoading
            ? _buildCategoryLoadingWidget()
            : products.isEmpty
            ? _buildEmptyCategoryWidget()
            : _buildProductsHorizontalList(products, state),
        SizedBox(height: AppPadding.p24),
      ],
    );
  }

  Widget _buildSectionHeader(CategoryEntity category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _formatCategoryName(category.name),
            style: AppTextstyle.tsSemiboldSize18.copyWith(
              color: AppColors.darkText,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryDetailScreen(
                    categorySlug: category.slug,
                    categoryName: category.name,
                  ),
                ),
              );
            },
            child: Text(
              'See all',
              style: AppTextstyle.tsRegularSize14.copyWith(
                color: AppColors.greenAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCategoryName(String name) {
    // Format category name for display
    return name
        .replaceAll('-', ' ')
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  Widget _buildCategoryLoadingWidget() {
    return SizedBox(
      height: 220,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.greenAccent,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildEmptyCategoryWidget() {
    return SizedBox(
      height: 220,
      child: Center(
        child: Text(
          'No products available',
          style: AppTextstyle.tsRegularSize14.copyWith(
            color: AppColors.grayText,
          ),
        ),
      ),
    );
  }

  Widget _buildProductsHorizontalList(
    List<ProductEntity> products,
    ShopState state,
  ) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isAddingThisProduct =
              state.isAddingToCart && state.addingProductId == product.id;

          return Padding(
            padding: EdgeInsets.only(
              right: index < products.length - 1 ? AppPadding.p12 : 0,
            ),
            child: ProductCardWidget(
              product: product,
              width: 160,
              isAddingToCart: isAddingThisProduct,
              onTap: () => _onProductTap(product),
              onAddToCart: () => _onAddToCart(product.id, state),
            ),
          );
        },
      ),
    );
  }

  void _onProductTap(ProductEntity product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  void _onAddToCart(int productId, ShopState state) {
    if (!state.isAddingToCart) {
      context.read<ShopBloc>().add(
        OnAddProductToCartEvent(productId: productId),
      );
    }
  }

  /// Build Groceries section with category chips
  Widget _buildGroceriesSection(ShopState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Groceries',
                style: AppTextstyle.tsSemiboldSize18.copyWith(
                  color: AppColors.darkText,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to explore screen or all groceries
                },
                child: Text(
                  'See all',
                  style: AppTextstyle.tsRegularSize14.copyWith(
                    color: AppColors.greenAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppPadding.p12),
        _buildCategoryChips(state),
        SizedBox(height: AppPadding.p16),
        _buildGroceriesProducts(state),
      ],
    );
  }

  Widget _buildCategoryChips(ShopState state) {
    final chipCategories = [
      _CategoryChip(
        name: 'Pulses',
        color: const Color(0xFFF8A44C),
        imagePath: Assets.images.imgPulses.path,
      ),
      _CategoryChip(
        name: 'Rice',
        color: const Color(0xFF53B175),
        imagePath: Assets.images.imgSackOfRice.path,
      ),
      _CategoryChip(
        name: 'Fresh Fruits \n& Vegetable',
        color: const Color(0xFFF8A44C),
        imagePath: Assets.images.imgFrashFruitVegetable.path,
      ),
      _CategoryChip(
        name: 'Meat & Fish',
        color: const Color(0xFFF7A593),
        imagePath: Assets.images.imgMeatAndFish.path,
      ),
      _CategoryChip(
        name: 'Beverages',
        color: const Color(0xFFB7DFF5),
        imagePath: Assets.images.imgBeverages.path,
      ),
    ];

    return SizedBox(
      height: 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        itemCount: chipCategories.length,
        itemBuilder: (context, index) {
          final chip = chipCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index < chipCategories.length - 1 ? AppPadding.p12 : 0,
            ),
            child: _buildCategoryChipItem(chip),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChipItem(_CategoryChip chip) {
    return GestureDetector(
      onTap: () {
        // Navigate to category
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(
              categorySlug: chip.name.toLowerCase(),
              categoryName: chip.name,
            ),
          ),
        );
      },
      child: Container(
        width: 250,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
        decoration: BoxDecoration(
          color: chip.color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Image.asset(
              chip.imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: chip.color.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.shopping_basket,
                    color: chip.color,
                    size: 30,
                  ),
                );
              },
            ),
            SizedBox(width: AppPadding.p12),
            Text(
              chip.name,
              style: AppTextstyle.tsSemiboldSize16.copyWith(
                color: AppColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroceriesProducts(ShopState state) {
    // Get products from groceries category if available
    final groceriesProducts = state.getProductsForCategory('groceries');

    if (groceriesProducts.isEmpty) {
      // Try to get products from the first available category
      for (final category in state.categories) {
        final products = state.getProductsForCategory(category.slug);
        if (products.isNotEmpty) {
          return _buildProductsHorizontalList(products, state);
        }
      }
      return const SizedBox.shrink();
    }

    return _buildProductsHorizontalList(groceriesProducts, state);
  }
}

/// Helper class for category chips
class _CategoryChip {
  final String name;
  final Color color;
  final String imagePath;

  _CategoryChip({
    required this.name,
    required this.color,
    required this.imagePath,
  });
}
