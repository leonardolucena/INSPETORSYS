abstract interface class ContrastPreferenceStorage {
  bool? readHighContrastEnabled();

  Future<void> saveHighContrastEnabled(bool enabled);
}
