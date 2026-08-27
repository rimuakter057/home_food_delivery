import 'package:flutter/foundation.dart';

/// Tracks which tab is active in the Shopper bottom nav — a shopper-scoped
/// counterpart to [HostNavigationState] so switching tabs in one role's
/// shell never leaks into another's.
class ShopperNavigationState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
