import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final AssetGenImage? background;

  const AppBackground({
    super.key,
    required this.child,
    this.padding,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    final bg = background ?? Assets.images.imgBackground;
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image covers
          bg.image(fit: BoxFit.cover, alignment: Alignment.topCenter),

          Padding(padding: padding ?? EdgeInsets.zero, child: child),
        ],
      ),
    );
  }
}
