import 'package:freezed_annotation/freezed_annotation.dart';

part 'inspection_sync_result.freezed.dart';

@freezed
abstract class InspectionSyncResult with _$InspectionSyncResult {
  const factory InspectionSyncResult({
    @Default(0) int processed,
    @Default(0) int synced,
    @Default(0) int keptPending,
    @Default(0) int markedFailed,
    @Default(0) int skipped,
  }) = _InspectionSyncResult;
}
