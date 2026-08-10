import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';

class LocalInspectionListItem extends Equatable {
  const LocalInspectionListItem({
    required this.inspection,
    this.workOrderCode,
    this.workOrderTitle,
  });

  final Inspection inspection;
  final String? workOrderCode;
  final String? workOrderTitle;

  @override
  List<Object?> get props => [
        inspection,
        workOrderCode,
        workOrderTitle,
      ];
}
