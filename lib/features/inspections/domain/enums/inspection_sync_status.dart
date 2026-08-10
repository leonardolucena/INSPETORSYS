import 'package:json_annotation/json_annotation.dart';

enum InspectionSyncStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('pending')
  pending,
  @JsonValue('synced')
  synced,
  @JsonValue('failed')
  failed,
}

extension InspectionSyncStatusX on InspectionSyncStatus {
  String get storageValue => switch (this) {
        InspectionSyncStatus.draft => 'draft',
        InspectionSyncStatus.pending => 'pending',
        InspectionSyncStatus.synced => 'synced',
        InspectionSyncStatus.failed => 'failed',
      };

  static InspectionSyncStatus fromStorage(String value) => switch (value) {
        'draft' => InspectionSyncStatus.draft,
        'pending' => InspectionSyncStatus.pending,
        'synced' => InspectionSyncStatus.synced,
        'failed' => InspectionSyncStatus.failed,
        _ => InspectionSyncStatus.draft,
      };

  String get label => switch (this) {
        InspectionSyncStatus.draft => 'Rascunho',
        InspectionSyncStatus.pending => 'Pendente',
        InspectionSyncStatus.synced => 'Enviado',
        InspectionSyncStatus.failed => 'Falhou',
      };
}
