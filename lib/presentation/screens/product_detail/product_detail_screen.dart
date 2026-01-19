import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/core/enums/button_style.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/screens/product_detail/widget/expandable_header.dart';
import 'package:online_groceries_store_app/presentation/screens/product_detail/widget/image_indicator.dart';
import 'package:online_groceries_store_app/presentation/screens/product_detail/widget/start_rating.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailBloc(getIt<CreateCartUsecase>(), FailureMapper(context)),
      child: _ProductDetailView(product: product),
    );
  }
}

class _ProductDetailView extends StatefulWidget {
  final ProductEntity product;

  const _ProductDetailView({required this.product});

  @override
  State<_ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<_ProductDetailView> {
  final PageController _imageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: _blocListener,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageSection(),
                      _buildProductInfo(state),
                      _buildQuantityAndPrice(state),
                      SizedBox(height: AppPadding.p8),
                      _buildProductDetailSection(state),
                      SizedBox(height: AppPadding.p8),
                      _buildNutritionsSection(),
                      SizedBox(height: AppPadding.p8),
                      _buildReviewSection(),
                      SizedBox(height: AppPadding.p24),
                    ],
                  ),
                ),
              ),
              _buildAddToBasketButton(state),
            ],
          );
        },
      ),
    );
  }

  void _blocListener(BuildContext context, ProductDetailState state) {
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

  Widget _buildImageSection() {
    final images = widget.product.images.isNotEmpty
        ? widget.product.images
        : [widget.product.thumbnail];

    return Container(
      color: const Color(0xFFF2F3F2),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _imageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(AppPadding.p24),
                    child: CachedNetworkImage(
                      imageUrl: images[index],
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.greenAccent,
                          strokeWidth: 2,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (images.length > 1) ImageIndicator(length: images.length, currentImageIndex: _currentImageIndex),
            SizedBox(height: AppPadding.p16),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
          ),
          IconButton(
            onPressed: () {
              // Share product
            },
            icon: const Icon(Icons.ios_share, color: AppColors.darkText),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(ProductDetailState state) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.product.title,
                  style: AppTextstyle.tsSemiboldSize24.copyWith(
                    color: AppColors.darkText,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<ProductDetailBloc>().add(
                    const OnToggleFavouriteEvent(),
                  );
                },
                icon: Icon(
                  state.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: state.isFavourite ? Colors.red : AppColors.grayText,
                  size: 28,
                ),
              ),
            ],
          ),
          SizedBox(height: AppPadding.p4),
          Text(
            '${widget.product.stock} pcs, Price',
            style: AppTextstyle.tsRegularSize16.copyWith(
              color: AppColors.grayText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityAndPrice(ProductDetailState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuantitySelector(state),
          Text(
            '\$${widget.product.price.toStringAsFixed(2)}',
            style: AppTextstyle.tsSemiboldSize24.copyWith(
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(ProductDetailState state) {
    return Row(
      children: [
        _buildQuantityButton(
          icon: Icons.remove,
          onPressed: () {
            context.read<ProductDetailBloc>().add(
              const OnDecrementQuantityEvent(),
            );
          },
          isEnabled: state.quantity > 1,
        ),
        Container(
          width: 45,
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.grayText.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              '${state.quantity}',
              style: AppTextstyle.tsSemiboldSize18.copyWith(
                color: AppColors.darkText,
              ),
            ),
          ),
        ),
        _buildQuantityButton(
          icon: Icons.add,
          onPressed: () {
            context.read<ProductDetailBloc>().add(
              const OnIncrementQuantityEvent(),
            );
          },
          isEnabled: true,
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Icon(
        icon,
        color: isEnabled ? AppColors.greenAccent : AppColors.grayText,
        size: 28,
      ),
    );
  }

  Widget _buildProductDetailSection(ProductDetailState state) {
    return Column(
      children: [
        ExpandableHeader(
          title: 'Product Detail',
          isExpanded: state.isProductDetailExpanded,
          onTap: () {
            context.read<ProductDetailBloc>().add(
              const OnToggleProductDetailEvent(),
            );
          },
        ),
        if (state.isProductDetailExpanded)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Padding(
              padding: EdgeInsets.only(bottom: AppPadding.p16),
              child: Text(
                widget.product.description,
                style: AppTextstyle.tsRegularSize14.copyWith(
                  color: AppColors.grayText,
                  height: 1.5,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNutritionsSection() {
    return InkWell(
      onTap: () {
        // Navigate to nutritions detail
      },
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: 'Nutritions',
              style: AppTextstyle.tsSemiboldSize16.copyWith(
                color: AppColors.darkText,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grayText.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${widget.product.weight}gr',
                    style: AppTextstyle.tsRegularSize14.copyWith(
                      color: AppColors.grayText,
                    ),
                  ),
                ),
                SizedBox(width: AppPadding.p8),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.darkText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection() {
    return InkWell(
      onTap: () {
        // Navigate to reviews
      },
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: 'Review',
              style: AppTextstyle.tsSemiboldSize16.copyWith(
                color: AppColors.darkText,
              ),
            ),
            Row(
              children: [
                StartRating(rating: widget.product.rating),
                SizedBox(width: AppPadding.p8),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.darkText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToBasketButton(ProductDetailState state) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: AppButton(
          variant: AppButtonVariant.primary,
          text: 'Add To Basket',
          height: 56,
          isLoading: state.isAddingToCart,
          onPressed: () {
            context.read<ProductDetailBloc>().add(
              OnAddToCartEvent(
                productId: widget.product.id,
                quantity: state.quantity,
              ),
            );
          },
        ),
      ),
    );
  }
}
