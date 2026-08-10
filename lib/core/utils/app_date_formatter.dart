import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

abstract final class AppDateFormatter {
  static const locale = 'pt_BR';

  static var _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    await initializeDateFormatting(locale);
    _initialized = true;
  }

  static String formatShortDate(DateTime date) {
    return DateFormat('dd/MM/yyyy', locale).format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm', locale).format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm', locale).format(date);
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
