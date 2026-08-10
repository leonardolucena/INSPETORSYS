import 'package:flutter/material.dart';
import 'package:inspetorsys/components/segmented_control.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

class WorkOrderStatusFilterBar extends StatelessWidget {
  const WorkOrderStatusFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  final WorkOrderStatus? selectedStatus;
  final ValueChanged<WorkOrderStatus?> onStatusSelected;

  static const _segments = <AppSegmentedControlSegment<WorkOrderStatus?>>[
    AppSegmentedControlSegment(value: null, label: 'Todas', flex: 2),
    AppSegmentedControlSegment(
      value: WorkOrderStatus.open,
      label: 'Aberta',
      flex: 2,
    ),
    AppSegmentedControlSegment(
      value: WorkOrderStatus.inProgress,
      label: 'Em andamento',
      flex: 5,
    ),
    AppSegmentedControlSegment(
      value: WorkOrderStatus.done,
      label: 'Concluída',
      flex: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppSegmentedControl<WorkOrderStatus?>(
      segments: _segments,
      selected: selectedStatus,
      onSelected: onStatusSelected,
    );
  }
}
