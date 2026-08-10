import 'package:dio/dio.dart';
import 'package:inspetorsys/core/constants/api_constants.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/dio_failure_mapper.dart';
import 'package:inspetorsys/core/network/dio_client.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_remote_data_source.dart';
import 'package:inspetorsys/features/work_orders/data/dto/work_order_dto.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkOrderRemoteDataSource)
class WorkOrderRemoteDataSourceImpl implements WorkOrderRemoteDataSource {
  WorkOrderRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<WorkOrderDto>> fetchWorkOrders({WorkOrderStatus? status}) async {
    try {
      final response = await _dioClient.client.get<List<dynamic>>(
        ApiConstants.workOrdersPath,
        queryParameters: status == null
            ? null
            : {
                'status': status.apiValue,
              },
      );

      final data = response.data ?? const [];
      return data
          .whereType<Map<String, dynamic>>()
          .map(WorkOrderDto.fromJson)
          .toList();
    } on DioException catch (exception) {
      throw mapDioExceptionToFailure(exception);
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<WorkOrderDto> fetchWorkOrderById(String id) async {
    try {
      final response = await _dioClient.client.get<Map<String, dynamic>>(
        ApiConstants.workOrderByIdPath(id),
      );

      return WorkOrderDto.fromJson(response.data!);
    } on DioException catch (exception) {
      throw mapDioExceptionToFailure(exception);
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<InspectionFormSchemaDto> fetchInspectionFormSchema(
    String workOrderId,
  ) async {
    try {
      final response = await _dioClient.client.get<Map<String, dynamic>>(
        ApiConstants.workOrderFormSchemaPath(workOrderId),
      );

      return InspectionFormSchemaDto.fromJson(response.data!);
    } on DioException catch (exception) {
      throw mapDioExceptionToFailure(exception);
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}
