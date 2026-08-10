abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const workOrderDetail = '/work-orders/:id';
  static const inspectionForm = '/work-orders/:workOrderId/inspection';
  static const inspectionDetail = '/inspections/:clientId';
  static const inspectionsHistory = '/inspections';

  static String workOrderDetailPath(String id) => '/work-orders/$id';

  static String inspectionFormPath(
    String workOrderId, {
    String? code,
    String? clientId,
  }) {
    final queryParameters = <String, String>{};
    if (code != null && code.isNotEmpty) {
      queryParameters['code'] = code;
    }
    if (clientId != null && clientId.isNotEmpty) {
      queryParameters['clientId'] = clientId;
    }

    return Uri(
      path: '/work-orders/$workOrderId/inspection',
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    ).toString();
  }

  static String inspectionDetailPath(String clientId) =>
      '/inspections/$clientId';
}
