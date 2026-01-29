/// A singleton manager for handling deep links throughout the app lifecycle.
///
/// This manager solves the race condition problem where:
/// 1. App opens via deep link
/// 2. OnboardingScreen auto-navigates to BottomTab
/// 3. Deep link navigation is lost
///
/// Solution: Store the pending deep link and process it after initial navigation completes.
class DeepLinkManager {
  DeepLinkManager._();
  static final DeepLinkManager instance = DeepLinkManager._();

  String? _pendingDeepLink;

  /// Store a deep link to be processed later
  void setPendingDeepLink(String link) {
    _pendingDeepLink = link;
  }

  /// Get and clear the pending deep link
  String? consumePendingDeepLink() {
    final link = _pendingDeepLink;
    _pendingDeepLink = null;
    return link;
  }

  /// Check if there is a pending deep link
  bool hasPendingDeepLink() {
    return _pendingDeepLink != null && _pendingDeepLink!.isNotEmpty;
  }

  /// Clear the pending deep link without consuming it
  void clearPendingDeepLink() {
    _pendingDeepLink = null;
  }
}
