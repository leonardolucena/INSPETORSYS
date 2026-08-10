import 'package:json_annotation/json_annotation.dart';

enum WorkOrderStatus {
  @JsonValue('open')
  open,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('done')
  done,
}

extension WorkOrderStatusX on WorkOrderStatus {
  String get apiValue => switch (this) {
        WorkOrderStatus.open => 'open',
        WorkOrderStatus.inProgress => 'in_progress',
        WorkOrderStatus.done => 'done',
      };

  String get label => switch (this) {
        WorkOrderStatus.open => 'Aberta',
        WorkOrderStatus.inProgress => 'Em andamento',
        WorkOrderStatus.done => 'Concluída',
      };

  static WorkOrderStatus fromApiValue(String value) => switch (value) {
        'open' => WorkOrderStatus.open,
        'in_progress' => WorkOrderStatus.inProgress,
        'done' => WorkOrderStatus.done,
        _ => WorkOrderStatus.open,
      };
}
