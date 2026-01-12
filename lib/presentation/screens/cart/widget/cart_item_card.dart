import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String thumbnail;
  final int quantity;
  final double price;
  final VoidCallback onRemove;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const CartItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.thumbnail,
    required this.quantity,
    required this.price,
    required this.onRemove,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.grayText.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          SizedBox(
            width: 72,
            height: 72,
            child: Image.network(
              thumbnail,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(width: 14),

          // Middle content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + X
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextstyle.tsSemiboldSize16.copyWith(
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: onRemove,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: AppColors.grayText.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                AppText(
                  text: subtitle,
                  style: AppTextstyle.tsRegularSize14.copyWith(
                    color: AppColors.grayText,
                  ),
                ),

                const SizedBox(height: 14),

                // Quantity row + price
                Row(
                  children: [
                    AppSquareIconButton(
                      icon: Icons.remove,
                      onPressed: onMinus,
                      size: 42,
                      borderRadius: 16,
                      backgroundColor: Colors.white,
                      borderColor: AppColors.grayText.withValues(alpha: 0.20),
                      iconColor: AppColors.grayText.withValues(alpha: 0.8),
                      iconSize: 22,
                      isEnabled: quantity > 1,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 22,
                      child: Center(
                        child: Text(
                          '$quantity',
                          style: AppTextstyle.tsSemiboldSize16.copyWith(
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    AppSquareIconButton(
                      icon: Icons.add,
                      onPressed: onPlus,
                      size: 42,
                      borderRadius: 16,
                      backgroundColor: Colors.white,
                      borderColor: AppColors.grayText.withValues(alpha: 0.20),
                      iconColor: AppColors.greenAccent,
                      iconSize: 22,
                    ),
                    const Spacer(),
                    AppText(
                      text: '\$${price.toStringAsFixed(2)}',
                      style: AppTextstyle.tsSemiboldSize18.copyWith(
                        color: AppColors.darkText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
