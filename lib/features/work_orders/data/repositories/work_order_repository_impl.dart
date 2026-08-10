import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_form_schema_cache_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';
import 'package:inspetorsys/features/inspections/domain/constants/default_inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_remote_data_source.dart';
import 'package:inspetorsys/features/work_orders/data/dto/work_order_dto.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/repositories/work_order_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkOrderRepository)
class WorkOrderRepositoryImpl implements WorkOrderRepository {
  WorkOrderRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._formSchemaCacheDataSource,
    this._networkMonitor,
  );

  final WorkOrderRemoteDataSource _remoteDataSource;
  final WorkOrderLocalDataSource _localDataSource;
  final InspectionFormSchemaCacheDataSource _formSchemaCacheDataSource;
  final NetworkMonitor _networkMonitor;

  @override
  Future<List<WorkOrder>> getCachedWorkOrders({WorkOrderStatus? status}) {
    return _localDataSource.getWorkOrders(status: status);
  }

  @override
  Future<WorkOrder?> getCachedWorkOrderById(String id) {
    return _localDataSource.getWorkOrderById(id);
  }

  @override
  AppAsyncResult<List<WorkOrder>> getWorkOrders({
    WorkOrderStatus? status,
    bool forceRefresh = false,
  }) async {
    try {
      final hasInternet = await _networkMonitor.hasInternetAccess();

      if (!hasInternet) {
        final cached = await _localDataSource.getWorkOrders(status: status);
        if (cached.isNotEmpty) {
          return appSuccess(cached);
        }

        return appFailure(const NetworkFailure());
      }

      try {
        final remoteItems = await _remoteDataSource.fetchWorkOrders(
          status: status,
        );
        final workOrders = remoteItems
            .map((dto) => dto.toDomain(cachedAt: DateTime.now()))
            .toList();

        if (status == null) {
          await _localDataSource.replaceAll(workOrders);
        } else {
          for (final workOrder in workOrders) {
            await _localDataSource.upsert(workOrder);
          }
        }
      } on AppFailure catch (failure) {
        if (forceRefresh) {
          final cached = await _localDataSource.getWorkOrders(status: status);
          if (cached.isNotEmpty) {
            return appSuccess(cached);
          }

          return appFailure(failure);
        }

        final cached = await _localDataSource.getWorkOrders(status: status);
        if (cached.isNotEmpty) {
          return appSuccess(cached);
        }

        return appFailure(failure);
      }

      final cached = await _localDataSource.getWorkOrders(status: status);
      return appSuccess(cached);
    } on AppFailure catch (failure) {
      return appFailure(failure);
    } catch (_) {
      return appFailure(const UnknownFailure());
    }
  }

  @override
  AppAsyncResult<WorkOrder> getWorkOrderById(String id) async {
    try {
      final hasInternet = await _networkMonitor.hasInternetAccess();

      if (!hasInternet) {
        final cached = await _localDataSource.getWorkOrderById(id);
        if (cached != null) {
          return appSuccess(cached);
        }

        return appFailure(const NetworkFailure());
      }

      try {
        final remoteItem = await _remoteDataSource.fetchWorkOrderById(id);
        final workOrder = remoteItem.toDomain(cachedAt: DateTime.now());
        await _localDataSource.upsert(workOrder);
        return appSuccess(workOrder);
      } on AppFailure catch (failure) {
        final cached = await _localDataSource.getWorkOrderById(id);
        if (cached != null) {
          return appSuccess(cached);
        }

        return appFailure(failure);
      }
    } on AppFailure catch (failure) {
      return appFailure(failure);
    } catch (_) {
      return appFailure(const UnknownFailure());
    }
  }

  @override
  AppAsyncResult<InspectionFormSchema> getInspectionFormSchema(
    String workOrderId,
  ) async {
    try {
      final hasInternet = await _networkMonitor.hasInternetAccess();

      if (!hasInternet) {
        return _resolveFormSchemaOffline(workOrderId);
      }

      try {
        final schema = await _remoteDataSource.fetchInspectionFormSchema(
          workOrderId,
        );

        await _formSchemaCacheDataSource.save(schema);

        return appSuccess(schema.toDomain());
      } on AppFailure {
        return _resolveFormSchemaOffline(workOrderId);
      }
    } on AppFailure catch (failure) {
      return appFailure(failure);
    } catch (_) {
      return appFailure(const UnknownFailure());
    }
  }

  Future<AppResult<InspectionFormSchema>> _resolveFormSchemaOffline(
    String workOrderId,
  ) async {
    final cached = await _formSchemaCacheDataSource.get(workOrderId);
    if (cached != null) {
      return appSuccess(cached.toDomain());
    }

    return appSuccess(
      DefaultInspectionFormSchema.forWorkOrder(workOrderId),
    );
  }
}
