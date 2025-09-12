import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('en'));

  final List<Locale> supportedLocales = [
    const Locale('en'),
    const Locale('bn'),
  ];

  void changeLocale(Locale locale) {
    if (state == locale) {
      return;
    }
    state = locale;
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});

final supportedLocalesProvider = Provider<List<Locale>>((ref) {
  return [const Locale('en'), const Locale('bn')];
});
