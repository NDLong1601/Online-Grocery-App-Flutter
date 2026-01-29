import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/presentation/routes/app_router.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';

/// Helper class to handle deep link navigation logic
class DeepLinkHelper {
  static void handleDeepLink(String link) {
    try {
      debugPrint("🔍 DeepLinkHelper: Processing link: $link");

      /// Tip: ➡️ Navigate to a specific page or take action based on the link
      /// "https://finn1601.chottu.link/product/123"

      if (link.contains("/product/")) {
        debugPrint("✅ Link contains '/product/'");
        final productId = link.split("/product/").last;
        debugPrint("🔍 Extracted productId string: $productId");

        final productIdInt = int.tryParse(productId);
        debugPrint("🔍 Parsed productId int: $productIdInt");

        if (productIdInt != null) {
          debugPrint(
            "➡️ Attempting to navigate to Product Detail for ID: $productId",
          );

          /// handle navigate -> product detail screen
          AppRouter.router.goNamed(
            RouteName.productDetailName,
            extra: {"productId": productIdInt, "isFromDeepLink": true},
          );

          debugPrint("✅ Navigation command sent!");
        } else {
          debugPrint("⚠️ Invalid product ID: $productId");
        }
      } else {
        debugPrint("⚠️ Unrecognized link format: $link");
      }
    } catch (e, stackTrace) {
      debugPrint("❌ Exception in DeepLinkHelper.handleDeepLink: $e");
      debugPrint("❌ StackTrace: $stackTrace");
    }
  }
}
