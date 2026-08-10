enum InspectionCondition {
  bom,
  regular,
  ruim,
  critico,
}

extension InspectionConditionX on InspectionCondition {
  String get apiValue => switch (this) {
        InspectionCondition.bom => 'bom',
        InspectionCondition.regular => 'regular',
        InspectionCondition.ruim => 'ruim',
        InspectionCondition.critico => 'crítico',
      };

  String get label => switch (this) {
        InspectionCondition.bom => 'Bom',
        InspectionCondition.regular => 'Regular',
        InspectionCondition.ruim => 'Ruim',
        InspectionCondition.critico => 'Crítico',
      };

  static InspectionCondition? fromApiValue(String? value) => switch (value) {
        'bom' => InspectionCondition.bom,
        'regular' => InspectionCondition.regular,
        'ruim' => InspectionCondition.ruim,
        'crítico' => InspectionCondition.critico,
        _ => null,
      };
}
