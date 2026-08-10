import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/locale/locale_preference_storage.dart';
import 'package:inspetorsys/core/utils/app_date_formatter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._localePreferenceStorage) : super(const Locale('pt'));

  final LocalePreferenceStorage _localePreferenceStorage;

  static const supportedLocales = [
    Locale('pt'),
    Locale('en'),
  ];

  Future<void> load() async {
    final savedLocale = _localePreferenceStorage.readLocale();
    if (savedLocale != null) {
      await AppDateFormatter.setLocale(savedLocale);
      emit(savedLocale);
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (state == locale) {
      return;
    }

    await _localePreferenceStorage.saveLocale(locale);
    await AppDateFormatter.setLocale(locale);
    emit(locale);
  }

  bool get isPortuguese => state.languageCode == 'pt';
}
