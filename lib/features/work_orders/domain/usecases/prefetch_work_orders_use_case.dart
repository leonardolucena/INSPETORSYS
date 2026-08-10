import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/maps/map_tile_cache_service.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/repositories/work_order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PrefetchWorkOrdersUseCase {
  PrefetchWorkOrdersUseCase(
    this._repository,
    this._networkMonitor,
    this._mapTileCacheService,
  );

  final WorkOrderRepository _repository;
  final NetworkMonitor _networkMonitor;
  final MapTileCacheService _mapTileCacheService;

  Future<void> call() async {
    final hasInternet = await _networkMonitor.hasInternetAccess();
    if (!hasInternet) {
      return;
    }

    final result = await _repository.getWorkOrders();
    await result.fold(
      (workOrders) async {
        for (final workOrder in workOrders) {
          if (workOrder.status != WorkOrderStatus.open) {
            continue;
          }

          await _repository.getWorkOrderById(workOrder.id);
          await _repository.getInspectionFormSchema(workOrder.id);

          final latitude = workOrder.latitude;
          final longitude = workOrder.longitude;
          if (latitude != null && longitude != null) {
            await _mapTileCacheService.prefetchAround(
              latitude: latitude,
              longitude: longitude,
            );
          }
        }
      },
      (_) async {},
    );
  }
}
