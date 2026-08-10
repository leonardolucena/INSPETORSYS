import 'package:flutter/material.dart';
import 'package:inspetorsys/components/segmented_control.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

class InspectionStatusFilterBar extends StatelessWidget {
  const InspectionStatusFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  final InspectionSyncStatus? selectedStatus;
  final ValueChanged<InspectionSyncStatus?> onStatusSelected;

  static const _segments = <AppSegmentedControlSegment<InspectionSyncStatus?>>[
    AppSegmentedControlSegment(value: null, label: 'Todas', flex: 2),
    AppSegmentedControlSegment(
      value: InspectionSyncStatus.draft,
      label: 'Rascunho',
      flex: 3,
    ),
    AppSegmentedControlSegment(
      value: InspectionSyncStatus.pending,
      label: 'Pendente',
      flex: 3,
    ),
    AppSegmentedControlSegment(
      value: InspectionSyncStatus.synced,
      label: 'Enviado',
      flex: 3,
    ),
    AppSegmentedControlSegment(
      value: InspectionSyncStatus.failed,
      label: 'Falhou',
      flex: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppSegmentedControl<InspectionSyncStatus?>(
      segments: _segments,
      selected: selectedStatus,
      onSelected: onStatusSelected,
    );
  }
}
