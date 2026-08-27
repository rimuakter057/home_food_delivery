import 'package:flutter/foundation.dart';

/// Tracks which tab is active in the Host bottom nav — a host-scoped
/// counterpart to [NavigationState] so switching tabs in one role's shell
/// never leaks into the other's.
class HostNavigationState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
