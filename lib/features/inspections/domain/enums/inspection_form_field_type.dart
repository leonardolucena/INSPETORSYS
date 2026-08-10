enum InspectionFormFieldType {
  text,
  select,
  photo,
  location,
  unknown,
}

extension InspectionFormFieldTypeX on InspectionFormFieldType {
  String get apiValue => switch (this) {
        InspectionFormFieldType.text => 'text',
        InspectionFormFieldType.select => 'select',
        InspectionFormFieldType.photo => 'photo',
        InspectionFormFieldType.location => 'location',
        InspectionFormFieldType.unknown => 'unknown',
      };

  static InspectionFormFieldType fromApiValue(String value) {
    return switch (value) {
      'text' => InspectionFormFieldType.text,
      'select' => InspectionFormFieldType.select,
      'photo' => InspectionFormFieldType.photo,
      'location' => InspectionFormFieldType.location,
      _ => InspectionFormFieldType.unknown,
    };
  }
}
