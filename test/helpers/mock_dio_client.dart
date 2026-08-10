import 'package:dio/dio.dart';
import 'package:inspetorsys/core/network/dio_client.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockDioClient extends Mock implements DioClient {}

class CapturedPostRequest {
  CapturedPostRequest({
    required this.path,
    required this.data,
    required this.options,
  });

  final String path;
  final Object? data;
  final Options? options;

  FormData get formData => data! as FormData;
}

class CapturedGetRequest {
  CapturedGetRequest({
    required this.path,
    required this.queryParameters,
  });

  final String path;
  final Map<String, dynamic>? queryParameters;
}

class DioClientMockHelper {
  DioClientMockHelper() {
    _dio = MockDio();
    _dioClient = MockDioClient();
    when(() => _dioClient.client).thenReturn(_dio);
  }

  late final MockDio _dio;
  late final MockDioClient _dioClient;

  final List<CapturedPostRequest> capturedPostRequests = [];
  final List<CapturedGetRequest> capturedGetRequests = [];

  MockDioClient get client => _dioClient;

  void mockGet({
    required String path,
    required List<Map<String, dynamic>> responseData,
    int statusCode = 200,
    Map<String, dynamic>? queryParameters,
  }) {
    when(
      () => _dio.get<List<dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((invocation) async {
      capturedGetRequests.add(
        CapturedGetRequest(
          path: invocation.positionalArguments.first as String,
          queryParameters:
              invocation.namedArguments[#queryParameters] as Map<String, dynamic>?,
        ),
      );

      return Response(
        requestOptions: RequestOptions(path: path),
        data: responseData,
        statusCode: statusCode,
      );
    });
  }

  void mockGetObject({
    required String path,
    required Map<String, dynamic> responseData,
    int statusCode = 200,
    Map<String, dynamic>? queryParameters,
  }) {
    when(
      () => _dio.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((invocation) async {
      capturedGetRequests.add(
        CapturedGetRequest(
          path: invocation.positionalArguments.first as String,
          queryParameters:
              invocation.namedArguments[#queryParameters] as Map<String, dynamic>?,
        ),
      );

      return Response(
        requestOptions: RequestOptions(path: path),
        data: responseData,
        statusCode: statusCode,
      );
    });
  }

  void mockPost({
    required String path,
    required Map<String, dynamic> responseData,
    int statusCode = 200,
  }) {
    when(
      () => _dio.post<Map<String, dynamic>>(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      ),
    ).thenAnswer((invocation) async {
      capturedPostRequests.add(
        CapturedPostRequest(
          path: invocation.positionalArguments.first as String,
          data: invocation.namedArguments[#data],
          options: invocation.namedArguments[#options] as Options?,
        ),
      );

      return Response(
        requestOptions: RequestOptions(path: path),
        data: responseData,
        statusCode: statusCode,
      );
    });
  }
}
