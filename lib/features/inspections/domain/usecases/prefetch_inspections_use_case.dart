import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/features/inspections/domain/repositories/inspection_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PrefetchInspectionsUseCase {
  PrefetchInspectionsUseCase(
    this._repository,
    this._networkMonitor,
  );

  final InspectionRepository _repository;
  final NetworkMonitor _networkMonitor;

  Future<void> call() async {
    final hasInternet = await _networkMonitor.hasInternetAccess();
    if (!hasInternet) {
      return;
    }

    await _repository.getInspections();
  }
}
