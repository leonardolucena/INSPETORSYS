import 'package:inspetorsys/features/inspections/domain/constants/inspection_form_constants.dart';

String? validateInspectionNotes(
  String notes, {
  int minLength = InspectionFormConstants.minNotesLength,
}) {
  final trimmed = notes.trim();

  if (trimmed.isEmpty) {
    return null;
  }

  if (trimmed.length < minLength) {
    return 'A observação deve ter no mínimo $minLength caracteres.';
  }

  return null;
}

String? validateInspectionNotesOnBlur(
  String notes, {
  int minLength = InspectionFormConstants.minNotesLength,
  bool required = true,
}) {
  final trimmed = notes.trim();

  if (trimmed.isEmpty) {
    return required ? 'A observação é obrigatória.' : null;
  }

  if (trimmed.length < minLength) {
    return 'A observação deve ter no mínimo $minLength caracteres.';
  }

  return null;
}
