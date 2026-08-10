import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/theme/contrast_preference_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HighContrastCubit extends Cubit<bool> {
  HighContrastCubit(this._contrastPreferenceStorage) : super(false);

  final ContrastPreferenceStorage _contrastPreferenceStorage;

  Future<void> load() async {
    final savedValue = _contrastPreferenceStorage.readHighContrastEnabled();
    if (savedValue != null) {
      emit(savedValue);
    }
  }

  Future<void> setEnabled(bool enabled) async {
    if (state == enabled) {
      return;
    }

    await _contrastPreferenceStorage.saveHighContrastEnabled(enabled);
    emit(enabled);
  }
}
