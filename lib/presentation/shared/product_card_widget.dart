import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/domain/entities/product_entity.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

/// Reusable Product card widget that can be used in grid or horizontal list
class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool isAddingToCart;
  final double? width;
  final double? height;

  const ProductCardWidget({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.isAddingToCart = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              SizedBox(height: AppPadding.p8),
              _buildProductTitle(),
              SizedBox(height: AppPadding.p4),
              _buildProductSubtitle(),
              const Spacer(),
              _buildPriceAndAddButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Expanded(
      flex: 3,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: product.thumbnail,
          fit: BoxFit.contain,
          placeholder: (context, url) => Container(
            color: Colors.grey[100],
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.greenAccent,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[200],
            child: const Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductTitle() {
    return AppText(
      text: product.title,
      style: AppTextstyle.tsSemiboldSize16.copyWith(color: AppColors.darkText),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductSubtitle() {
    return AppText(
      text: '${product.stock} pcs, Price',
      style: AppTextstyle.tsRegularSize14.copyWith(color: AppColors.grayText),
    );
  }

  Widget _buildPriceAndAddButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: AppTextstyle.tsSemiboldSize18.copyWith(
              color: AppColors.darkText,
            ),
          ),
        ),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildAddButton() {
    if (isAddingToCart) {
      return Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.greenAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return AppSquareIconButton(
      icon: Icons.add,
      onPressed: onAddToCart,
      size: 42,
      borderRadius: 16,
      backgroundColor: AppColors.greenAccent,
      borderColor: AppColors.grayText.withValues(alpha: 0.20),
      iconColor: Colors.white,
      iconSize: 22,
    );
  }
}
