import 'package:flutter/material.dart';

abstract interface class LocalePreferenceStorage {
  Locale? readLocale();

  Future<void> saveLocale(Locale locale);
}
