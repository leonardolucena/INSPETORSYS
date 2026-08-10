import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/features/inspections/domain/validators/inspection_notes_validator.dart';

void main() {
  test('returns null for empty notes', () {
    expect(validateInspectionNotes(''), isNull);
    expect(validateInspectionNotes('   '), isNull);
  });

  test('returns error when notes are shorter than 10 characters', () {
    expect(
      validateInspectionNotes('curta'),
      'A observação deve ter no mínimo 10 caracteres.',
    );
  });

  test('returns null when notes meet minimum length', () {
    expect(validateInspectionNotes('observação válida'), isNull);
  });

  test('on blur returns required error for empty notes', () {
    expect(
      validateInspectionNotesOnBlur(''),
      'A observação é obrigatória.',
    );
  });

  test('on blur returns length error for short notes', () {
    expect(
      validateInspectionNotesOnBlur('curta'),
      'A observação deve ter no mínimo 10 caracteres.',
    );
  });

  test('on blur returns null when notes meet minimum length', () {
    expect(validateInspectionNotesOnBlur('observação válida'), isNull);
  });
}
