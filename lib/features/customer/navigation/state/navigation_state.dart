import 'package:flutter/foundation.dart';

/// Tracks which bottom-nav tab is active so screens outside the shell
/// (e.g. the empty cart state) can switch tabs without a Navigator route.
class NavigationState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
