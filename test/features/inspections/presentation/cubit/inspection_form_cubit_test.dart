import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/core/image/image_exception.dart';
import 'package:inspetorsys/core/image/local_image_file.dart';
import 'package:inspetorsys/core/location/geo_coordinates.dart';
import 'package:inspetorsys/core/location/geo_distance_calculator.dart';
import 'package:inspetorsys/core/location/location_exception.dart';
import 'package:inspetorsys/core/location/location_service.dart';
import 'package:inspetorsys/core/permissions/permission_service.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/capture_inspection_location_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/capture_inspection_photo_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/complete_inspection_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_inspection_form_schema_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_local_inspection_by_client_id_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/save_inspection_draft_use_case.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_form_cubit.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_form_state.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_work_order_by_id_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockCaptureInspectionPhotoUseCase extends Mock
    implements CaptureInspectionPhotoUseCase {}

class MockCaptureInspectionLocationUseCase extends Mock
    implements CaptureInspectionLocationUseCase {}

class MockGetInspectionFormSchemaUseCase extends Mock
    implements GetInspectionFormSchemaUseCase {}

class MockGetWorkOrderByIdUseCase extends Mock
    implements GetWorkOrderByIdUseCase {}

class MockGetLocalInspectionByClientIdUseCase extends Mock
    implements GetLocalInspectionByClientIdUseCase {}

class MockSaveInspectionDraftUseCase extends Mock
    implements SaveInspectionDraftUseCase {}

class MockCompleteInspectionUseCase extends Mock
    implements CompleteInspectionUseCase {}

class MockGeoDistanceCalculator extends Mock implements GeoDistanceCalculator {}

class MockLocationService extends Mock implements LocationService {}

class MockPermissionService extends Mock implements PermissionService {}

const workOrderId = 'wo_1001';

const testFormSchema = InspectionFormSchema(
  workOrderId: workOrderId,
  fields: [
    InspectionFormFieldSchema(
      key: 'observation',
      type: InspectionFormFieldType.text,
      label: 'Observação',
      required: true,
      minLength: 10,
    ),
    InspectionFormFieldSchema(
      key: 'condition',
      type: InspectionFormFieldType.select,
      label: 'Condição do ativo',
      required: true,
      options: ['bom', 'regular', 'ruim', 'crítico'],
    ),
    InspectionFormFieldSchema(
      key: 'photo',
      type: InspectionFormFieldType.photo,
      label: 'Foto da evidência',
      required: true,
    ),
    InspectionFormFieldSchema(
      key: 'location',
      type: InspectionFormFieldType.location,
      label: 'Local da inspeção',
      required: true,
    ),
  ],
);

final testWorkOrder = WorkOrder(
  id: workOrderId,
  code: 'OS-2026-001',
  title: 'Inspeção de poste',
  address: 'Rua das Acácias, 120',
  priority: WorkOrderPriority.high,
  status: WorkOrderStatus.open,
  latitude: -7.1195,
  longitude: -34.845,
  createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
  updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
);

void main() {
  late MockCaptureInspectionPhotoUseCase capturePhotoUseCase;
  late MockCaptureInspectionLocationUseCase captureLocationUseCase;
  late MockGetInspectionFormSchemaUseCase getFormSchemaUseCase;
  late MockGetWorkOrderByIdUseCase getWorkOrderByIdUseCase;
  late MockGetLocalInspectionByClientIdUseCase getLocalInspectionByClientIdUseCase;
  late MockSaveInspectionDraftUseCase saveDraftUseCase;
  late MockCompleteInspectionUseCase completeInspectionUseCase;
  late MockGeoDistanceCalculator geoDistanceCalculator;
  late MockLocationService locationService;
  late MockPermissionService permissionService;

  setUpAll(() {
    registerFallbackValue(
      const SaveInspectionInput(workOrderId: workOrderId, notes: ''),
    );
  });

  final savedInspection = Inspection(
    clientId: 'client-123',
    workOrderId: workOrderId,
    status: InspectionSyncStatus.draft,
    createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
    updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
  );

  setUp(() {
    capturePhotoUseCase = MockCaptureInspectionPhotoUseCase();
    captureLocationUseCase = MockCaptureInspectionLocationUseCase();
    getFormSchemaUseCase = MockGetInspectionFormSchemaUseCase();
    getWorkOrderByIdUseCase = MockGetWorkOrderByIdUseCase();
    getLocalInspectionByClientIdUseCase =
        MockGetLocalInspectionByClientIdUseCase();
    saveDraftUseCase = MockSaveInspectionDraftUseCase();
    completeInspectionUseCase = MockCompleteInspectionUseCase();
    geoDistanceCalculator = MockGeoDistanceCalculator();
    locationService = MockLocationService();
    permissionService = MockPermissionService();
  });

  InspectionFormCubit buildCubit({String? inspectionClientId}) {
    return InspectionFormCubit(
      capturePhotoUseCase,
      captureLocationUseCase,
      getFormSchemaUseCase,
      getWorkOrderByIdUseCase,
      getLocalInspectionByClientIdUseCase,
      saveDraftUseCase,
      completeInspectionUseCase,
      geoDistanceCalculator,
      locationService,
      permissionService,
      workOrderId: workOrderId,
      inspectionClientId: inspectionClientId,
    );
  }

  test('initial state contains work order id', () {
    final cubit = buildCubit();

    expect(cubit.state, const InspectionFormState(workOrderId: workOrderId));

    cubit.close();
  });

  blocTest<InspectionFormCubit, InspectionFormState>(
    'loads form schema and work order coordinates',
    build: () {
      when(() => getFormSchemaUseCase(workOrderId))
          .thenAnswer((_) async => appSuccess(testFormSchema));
      when(() => getWorkOrderByIdUseCase(workOrderId))
          .thenAnswer((_) async => appSuccess(testWorkOrder));

      return buildCubit();
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.loading,
      ),
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        workOrderLatitude: -7.1195,
        workOrderLongitude: -34.845,
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'does not show notes validation error while typing',
    build: buildCubit,
    seed: () => const InspectionFormState(
      workOrderId: workOrderId,
      loadStatus: InspectionFormLoadStatus.success,
      formSchema: testFormSchema,
    ),
    act: (cubit) => cubit.onNotesChanged('curta'),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        notes: 'curta',
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'shows notes validation error when field loses focus with short text',
    build: buildCubit,
    seed: () => const InspectionFormState(
      workOrderId: workOrderId,
      loadStatus: InspectionFormLoadStatus.success,
      formSchema: testFormSchema,
      notes: 'curta',
    ),
    act: (cubit) => cubit.validateNotesField(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        notes: 'curta',
        notesError: 'A observação deve ter no mínimo 10 caracteres.',
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'clears notes validation error when text reaches minimum length',
    build: buildCubit,
    seed: () => const InspectionFormState(
      workOrderId: workOrderId,
      loadStatus: InspectionFormLoadStatus.success,
      formSchema: testFormSchema,
      notes: 'curta',
      notesError: 'A observação deve ter no mínimo 10 caracteres.',
    ),
    act: (cubit) => cubit.onNotesChanged('texto valido'),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        notes: 'texto valido',
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'loads existing draft when inspection client id is provided',
    build: () {
      when(() => getFormSchemaUseCase(workOrderId))
          .thenAnswer((_) async => appSuccess(testFormSchema));
      when(() => getWorkOrderByIdUseCase(workOrderId))
          .thenAnswer((_) async => appSuccess(testWorkOrder));
      when(() => getLocalInspectionByClientIdUseCase('client-123')).thenAnswer(
        (_) async => appSuccess(
          savedInspection.copyWith(
            notes: 'Observação salva',
            formData: const {'condition': 'bom'},
            latitude: -7.1195,
            longitude: -34.845,
          ),
        ),
      );

      return buildCubit(inspectionClientId: 'client-123');
    },
    act: (cubit) => cubit.load(),
    verify: (cubit) {
      expect(cubit.state.loadStatus, InspectionFormLoadStatus.success);
      expect(cubit.state.clientId, 'client-123');
      expect(cubit.state.notes, 'Observação salva');
      expect(cubit.state.condition, InspectionCondition.bom);
      expect(cubit.state.coordinates?.latitude, -7.1195);
      expect(cubit.state.coordinates?.longitude, -34.845);
    },
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'stores selected condition',
    build: buildCubit,
    act: (cubit) => cubit.onConditionChanged(InspectionCondition.bom),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        condition: InspectionCondition.bom,
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'stores captured photo path',
    build: () {
      when(() => capturePhotoUseCase()).thenAnswer(
        (_) async => const LocalImageFile(
          path: '/tmp/photo.jpg',
          sizeBytes: 2048,
        ),
      );

      return buildCubit();
    },
    act: (cubit) => cubit.capturePhoto(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        isCapturingPhoto: true,
      ),
      const InspectionFormState(
        workOrderId: workOrderId,
        photoPath: '/tmp/photo.jpg',
        photoSizeBytes: 2048,
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'handles denied location permission',
    build: () {
      when(() => captureLocationUseCase()).thenThrow(
        const AppLocationPermissionDeniedException(),
      );

      return buildCubit();
    },
    act: (cubit) => cubit.captureLocation(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        isCapturingLocation: true,
      ),
      const InspectionFormState(
        workOrderId: workOrderId,
        locationError: 'Permissão de localização negada.',
        showLocationSettingsAction: true,
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'shows geofence warning when gps is far from work order',
    build: () {
      when(() => captureLocationUseCase()).thenAnswer(
        (_) async => const GeoCoordinates(
          latitude: -7.15,
          longitude: -34.90,
        ),
      );
      when(
        () => geoDistanceCalculator.distanceInMeters(
          startLatitude: any(named: 'startLatitude'),
          startLongitude: any(named: 'startLongitude'),
          endLatitude: any(named: 'endLatitude'),
          endLongitude: any(named: 'endLongitude'),
        ),
      ).thenReturn(350);

      return buildCubit();
    },
    seed: () => const InspectionFormState(
      workOrderId: workOrderId,
      workOrderLatitude: -7.1195,
      workOrderLongitude: -34.845,
    ),
    act: (cubit) => cubit.captureLocation(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        workOrderLatitude: -7.1195,
        workOrderLongitude: -34.845,
        isCapturingLocation: true,
      ),
      const InspectionFormState(
        workOrderId: workOrderId,
        workOrderLatitude: -7.1195,
        workOrderLongitude: -34.845,
        coordinates: GeoCoordinates(
          latitude: -7.15,
          longitude: -34.90,
        ),
        geofenceWarning:
            'Você está a 350 m do ponto da OS (limite: 200 m).',
        distanceFromWorkOrderMeters: 350,
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'saves draft successfully',
    build: () {
      when(() => saveDraftUseCase(any())).thenAnswer(
        (_) async => appSuccess(savedInspection),
      );

      return buildCubit();
    },
    seed: () => const InspectionFormState(
      workOrderId: workOrderId,
      loadStatus: InspectionFormLoadStatus.success,
      formSchema: testFormSchema,
    ),
    act: (cubit) => cubit.saveDraft(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        saveStatus: InspectionFormSaveStatus.saving,
      ),
      InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        clientId: savedInspection.clientId,
        createdAt: savedInspection.createdAt,
        saveStatus: InspectionFormSaveStatus.draftSaved,
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'shows validation errors when completing with missing fields',
    build: buildCubit,
    seed: () => const InspectionFormState(
      workOrderId: workOrderId,
      loadStatus: InspectionFormLoadStatus.success,
      formSchema: testFormSchema,
    ),
    act: (cubit) => cubit.completeInspection(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        notesError: 'A observação é obrigatória.',
        photoError: 'A foto da inspeção é obrigatória.',
        locationError: 'A localização GPS é obrigatória.',
        conditionError: 'Selecione a condição do ativo.',
        saveStatus: InspectionFormSaveStatus.failure,
        saveErrorMessage: 'Preencha todos os campos obrigatórios.',
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'completes inspection successfully',
    build: () {
      when(() => completeInspectionUseCase(any())).thenAnswer(
        (_) async => appSuccess(
          savedInspection.copyWith(status: InspectionSyncStatus.pending),
        ),
      );

      return buildCubit();
    },
    seed: () => const InspectionFormState(
      workOrderId: workOrderId,
      loadStatus: InspectionFormLoadStatus.success,
      formSchema: testFormSchema,
      notes: 'Observação válida para conclusão',
      photoPath: '/tmp/photo.jpg',
      condition: InspectionCondition.regular,
      coordinates: GeoCoordinates(
        latitude: -7.1195,
        longitude: -34.845,
      ),
    ),
    act: (cubit) => cubit.completeInspection(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        notes: 'Observação válida para conclusão',
        photoPath: '/tmp/photo.jpg',
        condition: InspectionCondition.regular,
        coordinates: GeoCoordinates(
          latitude: -7.1195,
          longitude: -34.845,
        ),
        saveStatus: InspectionFormSaveStatus.saving,
      ),
      InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        notes: 'Observação válida para conclusão',
        photoPath: '/tmp/photo.jpg',
        condition: InspectionCondition.regular,
        coordinates: const GeoCoordinates(
          latitude: -7.1195,
          longitude: -34.845,
        ),
        clientId: savedInspection.clientId,
        createdAt: savedInspection.createdAt,
        saveStatus: InspectionFormSaveStatus.completed,
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'emits load failure when form schema fetch fails',
    build: () {
      when(() => getFormSchemaUseCase(workOrderId)).thenAnswer(
        (_) async => appFailure(
          const NetworkFailure(
            'Sem conexão com a internet. Verifique sua rede e tente novamente.',
          ),
        ),
      );
      when(() => getWorkOrderByIdUseCase(workOrderId))
          .thenAnswer((_) async => appSuccess(testWorkOrder));

      return buildCubit();
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.loading,
      ),
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.failure,
        loadErrorMessage:
            'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      ),
    ],
  );

  blocTest<InspectionFormCubit, InspectionFormState>(
    'shows network error when saving draft fails',
    build: () {
      when(() => saveDraftUseCase(any())).thenAnswer(
        (_) async => appFailure(const NetworkFailure()),
      );

      return buildCubit();
    },
    seed: () => const InspectionFormState(
      workOrderId: workOrderId,
      loadStatus: InspectionFormLoadStatus.success,
      formSchema: testFormSchema,
    ),
    act: (cubit) => cubit.saveDraft(),
    expect: () => [
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        saveStatus: InspectionFormSaveStatus.saving,
      ),
      const InspectionFormState(
        workOrderId: workOrderId,
        loadStatus: InspectionFormLoadStatus.success,
        formSchema: testFormSchema,
        saveStatus: InspectionFormSaveStatus.failure,
        saveErrorMessage: 'Sem conexão com a internet. Tente novamente.',
      ),
    ],
  );

  test('rethrows camera permission errors to the UI layer', () async {
    when(() => capturePhotoUseCase()).thenThrow(
      const ImagePermissionDeniedException(),
    );

    final cubit = buildCubit();

    await expectLater(
      cubit.capturePhoto(),
      throwsA(isA<ImagePermissionDeniedException>()),
    );
    expect(cubit.state.isCapturingPhoto, isFalse);

    await cubit.close();
  });
}
