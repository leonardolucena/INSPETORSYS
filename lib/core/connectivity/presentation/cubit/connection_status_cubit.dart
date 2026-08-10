import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/connectivity/network_status.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConnectionStatusCubit extends Cubit<NetworkStatus> {
  ConnectionStatusCubit(this._networkMonitor) : super(NetworkStatus.offline);

  final NetworkMonitor _networkMonitor;

  StreamSubscription<NetworkStatus>? _subscription;
  var _isMonitoring = false;

  void startMonitoring() {
    if (_isMonitoring) {
      return;
    }

    _isMonitoring = true;
    _subscription = _networkMonitor.onStatusChanged.listen(emit);
    unawaited(_networkMonitor.getStatus().then(emit));
  }

  void stopMonitoring() {
    _isMonitoring = false;
    _subscription?.cancel();
    _subscription = null;
    emit(NetworkStatus.offline);
  }

  @override
  Future<void> close() {
    stopMonitoring();
    return super.close();
  }
}
