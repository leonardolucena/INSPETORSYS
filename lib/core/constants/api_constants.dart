abstract final class ApiConstants {
  static const String emulatorBaseUrl = 'http://10.0.2.2:3000';
  static const String localhostBaseUrl = 'http://localhost:3000';

  /// Override at build/run time: `--dart-define=API_BASE_URL=http://<host>:3000`
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: emulatorBaseUrl,
  );

  static const String loginPath = '/auth/login';
  static const String currentUserPath = '/auth/me';
  static const String workOrdersPath = '/work-orders';

  static String workOrderByIdPath(String id) => '/work-orders/$id';

  static String workOrderFormSchemaPath(String id) =>
      '/work-orders/$id/form-schema';

  static const String inspectionsPath = '/inspections';

  static String inspectionByIdPath(String id) => '/inspections/$id';
}
