import 'package:inspetorsys/core/theme/contrast_preference_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ContrastPreferenceStorage)
class SharedPrefsContrastPreferenceStorage implements ContrastPreferenceStorage {
  SharedPrefsContrastPreferenceStorage(this._preferences);

  static const _highContrastKey = 'high_contrast_enabled';

  final SharedPreferences _preferences;

  @override
  bool? readHighContrastEnabled() {
    if (!_preferences.containsKey(_highContrastKey)) {
      return null;
    }

    return _preferences.getBool(_highContrastKey);
  }

  @override
  Future<void> saveHighContrastEnabled(bool enabled) {
    return _preferences.setBool(_highContrastKey, enabled);
  }
}
