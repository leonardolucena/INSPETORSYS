import 'package:json_annotation/json_annotation.dart';

enum WorkOrderPriority {
  @JsonValue('high')
  high,
  @JsonValue('medium')
  medium,
  @JsonValue('low')
  low,
}

extension WorkOrderPriorityX on WorkOrderPriority {
  String get apiValue => switch (this) {
        WorkOrderPriority.high => 'high',
        WorkOrderPriority.medium => 'medium',
        WorkOrderPriority.low => 'low',
      };

  String get label => switch (this) {
        WorkOrderPriority.high => 'Alta',
        WorkOrderPriority.medium => 'Média',
        WorkOrderPriority.low => 'Baixa',
      };

  static WorkOrderPriority fromApiValue(String value) => switch (value) {
        'high' => WorkOrderPriority.high,
        'medium' => WorkOrderPriority.medium,
        'low' => WorkOrderPriority.low,
        _ => WorkOrderPriority.medium,
      };
}
