import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/inspections/data/mappers/inspection_form_schema_persistence_mapper.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

extension InspectionLocalMapper on Inspection {
  InspectionsTableCompanion toCompanion() {
    return InspectionsTableCompanion.insert(
      clientId: clientId,
      serverId: Value(serverId),
      workOrderId: workOrderId,
      workOrderCode: Value(workOrderCode),
      workOrderLatitude: Value(workOrderLatitude),
      workOrderLongitude: Value(workOrderLongitude),
      status: status.storageValue,
      notes: Value(notes),
      photoPath: Value(photoPath),
      latitude: Value(latitude),
      longitude: Value(longitude),
      capturedAt: Value(capturedAt),
      formDataJson: Value(
        formData == null ? null : jsonEncode(formData),
      ),
      formSchemaJson: Value(formSchema?.toJsonString()),
      syncErrorMessage: Value(syncErrorMessage),
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncedAt: Value(syncedAt),
    );
  }
}

extension InspectionsTableDataMapper on InspectionsTableData {
  Inspection toDomain() {
    return Inspection(
      clientId: clientId,
      serverId: serverId,
      workOrderId: workOrderId,
      workOrderCode: workOrderCode,
      workOrderLatitude: workOrderLatitude,
      workOrderLongitude: workOrderLongitude,
      status: InspectionSyncStatusX.fromStorage(status),
      notes: notes,
      photoPath: photoPath,
      latitude: latitude,
      longitude: longitude,
      capturedAt: capturedAt,
      formData: _decodeFormData(formDataJson),
      formSchema: decodeInspectionFormSchema(formSchemaJson),
      syncErrorMessage: syncErrorMessage,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncedAt: syncedAt,
    );
  }
}

Map<String, dynamic>? _decodeFormData(String? formDataJson) {
  if (formDataJson == null || formDataJson.isEmpty) {
    return null;
  }

  final decoded = jsonDecode(formDataJson);
  if (decoded is Map<String, dynamic>) {
    return decoded;
  }

  return null;
}
