import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';

class ImageIndicator extends StatelessWidget {
  final int length;
  final int _currentImageIndex;

  const ImageIndicator({
    super.key,
    required this.length,
    required int currentImageIndex,
  }) : _currentImageIndex = currentImageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Container(
          width: index == _currentImageIndex ? 16 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == _currentImageIndex
                ? AppColors.greenAccent
                : AppColors.grayText.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}