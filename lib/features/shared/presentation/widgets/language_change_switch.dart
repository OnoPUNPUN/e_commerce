import 'package:e_commerce/app/controllers/language_controller.dart';
import 'package:e_commerce/app/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageChangeSwitch extends ConsumerWidget {
  const LanguageChangeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supportedLocales = ref.watch(supportedLocalesProvider);

    return ListTile(
      title: Text(context.localization.selectLanguage),
      trailing: DropdownMenu<Locale>(
        dropdownMenuEntries: supportedLocales.map((locale) {
          return DropdownMenuEntry(value: locale, label: locale.languageCode);
        }).toList(),
        onSelected: (Locale? locale) {
          ref.read(languageProvider.notifier).changeLocale(locale!);
        },
      ),
    );
  }
}
