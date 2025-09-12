import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavbarNotifier extends StateNotifier<int> {
  MainNavbarNotifier() : super(0);

  void changeIndex(int index) {
    if (state == index) {
      return;
    }
    state = index;
  }

  void moveToCategories() {
    changeIndex(1);
  }

  void backToHome() {
    changeIndex(0);
  }
}

final mainNavbarProvider = StateNotifierProvider<MainNavbarNotifier, int>((
  ref,
) {
  return MainNavbarNotifier();
});
