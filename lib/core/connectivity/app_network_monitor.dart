import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/connectivity/network_status.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

@LazySingleton(as: NetworkMonitor)
class AppNetworkMonitor implements NetworkMonitor {
  AppNetworkMonitor(
    this._connectivity,
    this._internetConnection,
  ) {
    _statusController.onListen = _startListening;
    _statusController.onCancel = _handleStatusStreamCancel;
  }

  static const _internetCheckTimeout = Duration(seconds: 5);

  final Connectivity _connectivity;
  final InternetConnection _internetConnection;
  final _statusController = StreamController<NetworkStatus>.broadcast();

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<InternetStatus>? _internetSubscription;
  NetworkStatus? _lastStatus;
  var _listenerCount = 0;

  @override
  Future<bool> hasActiveNetworkInterface() async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }

  @override
  Future<bool> hasInternetAccess() async {
    if (!await hasActiveNetworkInterface()) {
      return false;
    }

    try {
      return await _internetConnection.hasInternetAccess
          .timeout(_internetCheckTimeout);
    } on TimeoutException {
      // Interface is up (e.g. emulator + local mock API) but the public probe
      // may be slow or blocked — allow the app to try its own API endpoints.
      return true;
    }
  }

  @override
  Future<NetworkStatus> getStatus() async {
    if (!await hasActiveNetworkInterface()) {
      return NetworkStatus.offline;
    }

    try {
      final hasInternet = await _internetConnection.hasInternetAccess
          .timeout(_internetCheckTimeout);
      return hasInternet
          ? NetworkStatus.online
          : NetworkStatus.connectedNoInternet;
    } on TimeoutException {
      return NetworkStatus.online;
    }
  }

  @override
  Stream<NetworkStatus> get onStatusChanged => _statusController.stream;

  void _startListening() {
    _listenerCount++;
    if (_listenerCount > 1) {
      return;
    }

    unawaited(_emitStatusIfChanged());

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((_) {
      unawaited(_emitStatusIfChanged());
    });

    _internetSubscription =
        _internetConnection.onStatusChange.listen((_) {
      unawaited(_emitStatusIfChanged());
    });
  }

  void _handleStatusStreamCancel() {
    _listenerCount--;
    if (_listenerCount > 0) {
      return;
    }

    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;

    _internetSubscription?.cancel();
    _internetSubscription = null;
  }

  Future<void> _emitStatusIfChanged() async {
    final status = await getStatus();
    if (status == _lastStatus) {
      return;
    }

    _lastStatus = status;
    if (!_statusController.isClosed) {
      _statusController.add(status);
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _internetSubscription?.cancel();
    _statusController.close();
    _internetConnection.dispose();
  }
}
