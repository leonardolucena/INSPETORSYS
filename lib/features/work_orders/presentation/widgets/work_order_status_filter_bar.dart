import 'package:flutter/material.dart';
import 'package:inspetorsys/components/segmented_control.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

class WorkOrderStatusFilterBar extends StatelessWidget {
  const WorkOrderStatusFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  final WorkOrderStatus? selectedStatus;
  final ValueChanged<WorkOrderStatus?> onStatusSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppSegmentedControl<WorkOrderStatus?>(
      segments: [
        AppSegmentedControlSegment(value: null, label: l10n.filterAll, flex: 2),
        AppSegmentedControlSegment(
          value: WorkOrderStatus.open,
          label: WorkOrderStatus.open.localizedLabel(l10n),
          flex: 2,
        ),
        AppSegmentedControlSegment(
          value: WorkOrderStatus.inProgress,
          label: WorkOrderStatus.inProgress.localizedLabel(l10n),
          flex: 5,
        ),
        AppSegmentedControlSegment(
          value: WorkOrderStatus.done,
          label: WorkOrderStatus.done.localizedLabel(l10n),
          flex: 3,
        ),
      ],
      selected: selectedStatus,
      onSelected: onStatusSelected,
    );
  }
}
