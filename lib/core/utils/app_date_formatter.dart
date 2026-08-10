import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

abstract final class AppDateFormatter {
  static const _portugueseLocale = 'pt_BR';
  static const _englishLocale = 'en_US';

  static var _locale = _portugueseLocale;
  static var _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    await initializeDateFormatting(_locale);
    _initialized = true;
  }

  static Future<void> setLocale(Locale locale) async {
    final localeName =
        locale.languageCode == 'en' ? _englishLocale : _portugueseLocale;

    if (_locale == localeName && _initialized) {
      return;
    }

    await initializeDateFormatting(localeName);
    _locale = localeName;
    _initialized = true;
  }

  static String formatShortDate(DateTime date) {
    return DateFormat('dd/MM/yyyy', _locale).format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm', _locale).format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm', _locale).format(date);
  }

  static String? formatShortDateNullable(DateTime? date) {
    return date == null ? null : formatShortDate(date);
  }

  static String? formatDateTimeNullable(DateTime? date) {
    return date == null ? null : formatDateTime(date);
  }
}

extension DateTimeFormatting on DateTime {
  String get toShortDate => AppDateFormatter.formatShortDate(this);

  String get toDateTimeLabel => AppDateFormatter.formatDateTime(this);

  String get toTimeLabel => AppDateFormatter.formatTime(this);
}

extension NullableDateTimeFormatting on DateTime? {
  String? get toShortDateOrNull => AppDateFormatter.formatShortDateNullable(this);

  String? get toDateTimeLabelOrNull =>
      AppDateFormatter.formatDateTimeNullable(this);
}
