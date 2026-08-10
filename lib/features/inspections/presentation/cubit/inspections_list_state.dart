import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/inspections/domain/entities/local_inspection_list_item.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

enum InspectionsListStatus {
  initial,
  loading,
  success,
  empty,
  failure,
}

class InspectionsListState extends Equatable {
  const InspectionsListState({
    this.status = InspectionsListStatus.initial,
    this.inspections = const [],
    this.statusFilter,
    this.codeSearchQuery = '',
    this.errorMessage,
    this.isRefreshing = false,
    this.retryingClientId,
    this.actionFeedbackMessage,
    this.actionFeedbackSuccess = false,
  });

  const InspectionsListState.initial() : this();

  final InspectionsListStatus status;
  final List<LocalInspectionListItem> inspections;
  final InspectionSyncStatus? statusFilter;
  final String codeSearchQuery;
  final String? errorMessage;
  final bool isRefreshing;
  final String? retryingClientId;
  final String? actionFeedbackMessage;
  final bool actionFeedbackSuccess;

  List<LocalInspectionListItem> get visibleInspections {
    final query = codeSearchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return inspections;
    }

    return inspections
        .where(
          (item) =>
              (item.workOrderCode ?? '').toLowerCase().contains(query),
        )
        .toList();
  }

  bool get hasActiveCodeSearch => codeSearchQuery.trim().isNotEmpty;

  InspectionsListState copyWith({
    InspectionsListStatus? status,
    List<LocalInspectionListItem>? inspections,
    InspectionSyncStatus? statusFilter,
    String? codeSearchQuery,
    String? errorMessage,
    bool? isRefreshing,
    String? retryingClientId,
    String? actionFeedbackMessage,
    bool? actionFeedbackSuccess,
    bool clearStatusFilter = false,
    bool clearErrorMessage = false,
    bool clearCodeSearchQuery = false,
    bool clearRetryingClientId = false,
    bool clearActionFeedback = false,
  }) {
    return InspectionsListState(
      status: status ?? this.status,
      inspections: inspections ?? this.inspections,
      statusFilter: clearStatusFilter
          ? null
          : (statusFilter ?? this.statusFilter),
      codeSearchQuery: clearCodeSearchQuery
          ? ''
          : (codeSearchQuery ?? this.codeSearchQuery),
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      isRefreshing: isRefreshing ?? this.isRefreshing,
      retryingClientId: clearRetryingClientId
          ? null
          : (retryingClientId ?? this.retryingClientId),
      actionFeedbackMessage: clearActionFeedback
          ? null
          : (actionFeedbackMessage ?? this.actionFeedbackMessage),
      actionFeedbackSuccess:
          actionFeedbackSuccess ?? this.actionFeedbackSuccess,
    );
  }

  @override
  List<Object?> get props => [
        status,
        inspections,
        statusFilter,
        codeSearchQuery,
        errorMessage,
        isRefreshing,
        retryingClientId,
        actionFeedbackMessage,
        actionFeedbackSuccess,
      ];
}
