import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle; // ví dụ: "1kg, Price"
  final String thumbnail;
  final int quantity;
  final double price; // hiển thị bên phải
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

                Text(
                  subtitle,
                  style: AppTextstyle.tsRegularSize14.copyWith(
                    color: AppColors.grayText,
                  ),
                ),

                const SizedBox(height: 14),

                // Quantity row + price
                Row(
                  children: [
                    _QtyButton(
                      icon: Icons.remove,
                      onTap: onMinus,
                      iconColor: AppColors.grayText.withValues(alpha: 0.7),
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
                    _QtyButton(
                      icon: Icons.add,
                      onTap: onPlus,
                      iconColor: AppColors.greenAccent,
                    ),
                    const Spacer(),
                    Text(
                      '\$${price.toStringAsFixed(2)}',
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

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _QtyButton({
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.grayText.withValues(alpha: 0.20),
            width: 1,
          ),
        ),
      ),
    );
  }
}
