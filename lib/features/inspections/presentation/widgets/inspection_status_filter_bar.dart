import 'package:flutter/material.dart';
import 'package:inspetorsys/components/segmented_control.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

class InspectionStatusFilterBar extends StatelessWidget {
  const InspectionStatusFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  final InspectionSyncStatus? selectedStatus;
  final ValueChanged<InspectionSyncStatus?> onStatusSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppSegmentedControl<InspectionSyncStatus?>(
      segments: [
        AppSegmentedControlSegment(value: null, label: l10n.filterAll, flex: 2),
        AppSegmentedControlSegment(
          value: InspectionSyncStatus.draft,
          label: InspectionSyncStatus.draft.localizedLabel(l10n),
          flex: 3,
        ),
        AppSegmentedControlSegment(
          value: InspectionSyncStatus.pending,
          label: InspectionSyncStatus.pending.localizedLabel(l10n),
          flex: 3,
        ),
        AppSegmentedControlSegment(
          value: InspectionSyncStatus.synced,
          label: InspectionSyncStatus.synced.localizedLabel(l10n),
          flex: 3,
        ),
        AppSegmentedControlSegment(
          value: InspectionSyncStatus.failed,
          label: InspectionSyncStatus.failed.localizedLabel(l10n),
          flex: 2,
        ),
      ],
      selected: selectedStatus,
      onSelected: onStatusSelected,
    );
  }
}
