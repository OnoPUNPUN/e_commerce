import 'package:e_commerce/app/app_theme.dart';
import 'package:e_commerce/app/controllers/language_controller.dart';
import 'package:e_commerce/app/routes.dart';
import 'package:e_commerce/features/auth/presentation/screens/splash_screen.dart';
import 'package:e_commerce/l10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CraftyBay extends ConsumerStatefulWidget {
  const CraftyBay({super.key});

  @override
  ConsumerState<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends ConsumerState<CraftyBay> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(languageProvider);
    final supportedLocales = ref.watch(supportedLocalesProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorObservers: [observer],
      locale: currentLocale,
      supportedLocales: supportedLocales,
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
