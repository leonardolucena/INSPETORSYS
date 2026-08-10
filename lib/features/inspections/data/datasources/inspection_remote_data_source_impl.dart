import 'dart:io';

import 'package:dio/dio.dart';
import 'package:inspetorsys/core/constants/api_constants.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/dio_failure_mapper.dart';
import 'package:inspetorsys/core/network/dio_client.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_dto.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_data.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;

@LazySingleton(as: InspectionRemoteDataSource)
class InspectionRemoteDataSourceImpl implements InspectionRemoteDataSource {
  InspectionRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<InspectionDto> uploadInspection(Inspection inspection) async {
    if (inspection.status == InspectionSyncStatus.draft) {
      throw const CacheFailure('Rascunhos não podem ser enviados para a API.');
    }

    final photoPath = inspection.photoPath;
    if (photoPath == null || photoPath.isEmpty) {
      throw const CacheFailure('Foto da inspeção não encontrada para envio.');
    }

    final photoFile = File(photoPath);
    if (!photoFile.existsSync()) {
      throw const CacheFailure('Arquivo da foto não encontrado no dispositivo.');
    }

    final condition = readInspectionCondition(inspection.formData)?.apiValue;

    try {
      final formData = FormData.fromMap({
        'clientId': inspection.clientId,
        'workOrderId': inspection.workOrderId,
        'observation': inspection.notes ?? '',
        'condition': ?condition,
        'latitude': inspection.latitude,
        'longitude': inspection.longitude,
        'capturedAt': (inspection.capturedAt ?? inspection.updatedAt)
            .toUtc()
            .toIso8601String(),
        'photo': await MultipartFile.fromFile(
          photoPath,
          filename: p.basename(photoPath),
        ),
      });

      final response = await _dioClient.client.post<Map<String, dynamic>>(
        ApiConstants.inspectionsPath,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          validateStatus: (status) => status == 200 || status == 201,
        ),
      );

      final data = response.data;
      if (data == null) {
        throw const ServerFailure('Resposta inválida ao enviar inspeção.');
      }

      return InspectionDto.fromJson(data);
    } on DioException catch (exception) {
      throw mapDioExceptionToFailure(exception);
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}
