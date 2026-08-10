import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source_impl.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_dto.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

import '../../../../helpers/mock_dio_client.dart';

void main() {
  late DioClientMockHelper dioHelper;
  late InspectionRemoteDataSourceImpl dataSource;
  late File fixturePhoto;

  const clientId = 'client-abc';

  setUpAll(() async {
    fixturePhoto = File('test/fixtures/photo.jpg');
    await fixturePhoto.parent.create(recursive: true);
    await fixturePhoto.writeAsBytes(const [0xFF, 0xD8, 0xFF, 0xD9]);
  });

  final inspection = Inspection(
    clientId: clientId,
    workOrderId: 'wo_1001',
    status: InspectionSyncStatus.pending,
    notes: 'Observação válida para envio',
    photoPath: '',
    latitude: -7.1195,
    longitude: -34.845,
    formData: const {'condition': 'bom'},
    createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
    updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
  );

  setUp(() {
    dioHelper = DioClientMockHelper();
    dataSource = InspectionRemoteDataSourceImpl(dioHelper.client);
  });

  Inspection inspectionWithPhoto() {
    return inspection.copyWith(photoPath: fixturePhoto.path);
  }

  test('fetchInspections returns parsed inspection list', () async {
    dioHelper.mockGet(
      path: '/inspections',
      responseData: [
        {
          'id': 'insp_1',
          'clientId': clientId,
          'workOrderId': 'wo_1001',
          'observation': 'Inspeção remota',
          'photoUrl': '/uploads/photo.jpg',
          'latitude': -7.1195,
          'longitude': -34.845,
          'capturedAt': '2026-07-26T12:00:00.000Z',
          'syncedAt': '2026-07-26T13:00:00.000Z',
        },
      ],
    );

    final result = await dataSource.fetchInspections();

    expect(result, hasLength(1));
    expect(result.single.clientId, clientId);
    expect(dioHelper.capturedGetRequests.single.path, '/inspections');
  });

  test('fetchInspectionById returns parsed inspection', () async {
    dioHelper.mockGetObject(
      path: '/inspections/$clientId',
      responseData: {
        'id': 'insp_1',
        'clientId': clientId,
        'workOrderId': 'wo_1001',
        'observation': 'Inspeção remota',
        'photoUrl': '/uploads/photo.jpg',
        'latitude': -7.1195,
        'longitude': -34.845,
        'capturedAt': '2026-07-26T12:00:00.000Z',
        'syncedAt': '2026-07-26T13:00:00.000Z',
      },
    );

    final result = await dataSource.fetchInspectionById(clientId);

    expect(result.clientId, clientId);
    expect(result.id, 'insp_1');
    expect(dioHelper.capturedGetRequests.single.path, '/inspections/$clientId');
  });

  test('uploads inspection as multipart form data with clientId', () async {
    dioHelper.mockPost(
      path: '/inspections',
      responseData: {
        'id': 'insp_1',
        'clientId': clientId,
        'workOrderId': 'wo_1001',
        'observation': 'Observação válida para envio',
        'condition': 'bom',
        'photoUrl': '/uploads/photo.jpg',
        'latitude': -7.1195,
        'longitude': -34.845,
        'capturedAt': '2026-07-26T12:00:00.000Z',
        'syncedAt': '2026-07-26T13:00:00.000Z',
      },
      statusCode: 201,
    );

    final result = await dataSource.uploadInspection(inspectionWithPhoto());

    expect(result, isA<InspectionDto>());
    expect(result.clientId, clientId);
    expect(result.id, 'insp_1');

    final captured = dioHelper.capturedPostRequests.single.formData;
    expect(
      captured.fields.firstWhere((field) => field.key == 'clientId').value,
      clientId,
    );
    expect(captured.files.single.key, 'photo');
  });

  test('accepts 200 response for idempotent upload', () async {
    dioHelper.mockPost(
      path: '/inspections',
      responseData: {
        'id': 'insp_1',
        'clientId': clientId,
        'workOrderId': 'wo_1001',
        'observation': 'Observação válida para envio',
        'photoUrl': '/uploads/photo.jpg',
        'latitude': -7.1195,
        'longitude': -34.845,
        'capturedAt': '2026-07-26T12:00:00.000Z',
        'syncedAt': '2026-07-26T13:00:00.000Z',
      },
      statusCode: 200,
    );

    final result = await dataSource.uploadInspection(inspectionWithPhoto());

    expect(result.clientId, clientId);
  });

  test('throws cache failure when photo file is missing', () async {
    await expectLater(
      dataSource.uploadInspection(inspection.copyWith(photoPath: null)),
      throwsA(isA<CacheFailure>()),
    );
  });

  test('throws cache failure when inspection is draft', () async {
    await expectLater(
      dataSource.uploadInspection(
        inspectionWithPhoto().copyWith(
          status: InspectionSyncStatus.draft,
        ),
      ),
      throwsA(isA<CacheFailure>()),
    );
  });
}
