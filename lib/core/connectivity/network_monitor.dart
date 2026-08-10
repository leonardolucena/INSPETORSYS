import 'package:inspetorsys/core/connectivity/network_status.dart';

abstract interface class NetworkMonitor {
  Future<bool> hasActiveNetworkInterface();

  Future<bool> hasInternetAccess();

  Future<NetworkStatus> getStatus();

  Stream<NetworkStatus> get onStatusChanged;

  void dispose();
}
