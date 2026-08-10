import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';

enum InspectionDetailStatus {
  initial,
  loading,
  success,
  failure,
}

class InspectionDetailState extends Equatable {
  const InspectionDetailState({
    this.status = InspectionDetailStatus.initial,
    this.inspection,
    this.workOrderCode,
    this.workOrderTitle,
    this.errorMessage,
  });

  const InspectionDetailState.initial() : this();

  final InspectionDetailStatus status;
  final Inspection? inspection;
  final String? workOrderCode;
  final String? workOrderTitle;
  final String? errorMessage;

  InspectionDetailState copyWith({
    InspectionDetailStatus? status,
    Inspection? inspection,
    String? workOrderCode,
    String? workOrderTitle,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return InspectionDetailState(
      status: status ?? this.status,
      inspection: inspection ?? this.inspection,
      workOrderCode: workOrderCode ?? this.workOrderCode,
      workOrderTitle: workOrderTitle ?? this.workOrderTitle,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        inspection,
        workOrderCode,
        workOrderTitle,
        errorMessage,
      ];
}
