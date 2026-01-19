import 'package:flutter/material.dart';

class StartRating extends StatelessWidget {
  final double rating;

  const StartRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          fullStars,
          (index) => const Icon(Icons.star, color: Color(0xFFF3603F), size: 18),
        ),
        if (hasHalfStar)
          const Icon(Icons.star_half, color: Color(0xFFF3603F), size: 18),
        ...List.generate(
          emptyStars,
          (index) =>
              const Icon(Icons.star_border, color: Color(0xFFF3603F), size: 18),
        ),
      ],
    );
  }
}
