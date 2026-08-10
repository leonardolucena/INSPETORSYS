import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/local_inspection_list_item.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_local_inspections_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/retry_failed_inspection_use_case.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspections_list_cubit.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspections_list_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetLocalInspectionsUseCase extends Mock
    implements GetLocalInspectionsUseCase {}

class MockRetryFailedInspectionUseCase extends Mock
    implements RetryFailedInspectionUseCase {}

final testItem = LocalInspectionListItem(
  inspection: Inspection(
    clientId: 'client-123',
    workOrderId: 'wo_1001',
    status: InspectionSyncStatus.pending,
    notes: 'Observação da inspeção',
    createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
    updatedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
  ),
  workOrderCode: 'OS-2026-001',
  workOrderTitle: 'Inspeção de poste',
);

void main() {
  late MockGetLocalInspectionsUseCase getLocalInspectionsUseCase;
  late MockRetryFailedInspectionUseCase retryFailedInspectionUseCase;
  late InspectionsListCubit cubit;

  setUp(() {
    getLocalInspectionsUseCase = MockGetLocalInspectionsUseCase();
    retryFailedInspectionUseCase = MockRetryFailedInspectionUseCase();
    cubit = InspectionsListCubit(
      getLocalInspectionsUseCase,
      retryFailedInspectionUseCase,
    );
  });

  tearDown(() => cubit.close());

  blocTest<InspectionsListCubit, InspectionsListState>(
    'emits success when inspections are loaded',
    build: () {
      when(() => getLocalInspectionsUseCase(status: any(named: 'status')))
          .thenAnswer((_) async => appSuccess([testItem]));
      return cubit;
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const InspectionsListState(
        status: InspectionsListStatus.loading,
      ),
      InspectionsListState(
        status: InspectionsListStatus.success,
        inspections: [testItem],
      ),
    ],
  );

  blocTest<InspectionsListCubit, InspectionsListState>(
    'emits empty when no inspections are returned',
    build: () {
      when(() => getLocalInspectionsUseCase(status: any(named: 'status')))
          .thenAnswer((_) async => appSuccess(const []));
      return cubit;
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const InspectionsListState(
        status: InspectionsListStatus.loading,
      ),
      const InspectionsListState(
        status: InspectionsListStatus.empty,
      ),
    ],
  );

  blocTest<InspectionsListCubit, InspectionsListState>(
    'emits failure when loading fails',
    build: () {
      when(() => getLocalInspectionsUseCase(status: any(named: 'status')))
          .thenAnswer((_) async => appFailure(const CacheFailure()));
      return cubit;
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const InspectionsListState(
        status: InspectionsListStatus.loading,
      ),
      const InspectionsListState(
        status: InspectionsListStatus.failure,
        errorMessage: 'Não foi possível acessar os dados locais.',
      ),
    ],
  );

  blocTest<InspectionsListCubit, InspectionsListState>(
    'reloads with status filter',
    build: () {
      when(
        () => getLocalInspectionsUseCase(
          status: InspectionSyncStatus.failed,
        ),
      ).thenAnswer((_) async => appSuccess([testItem]));
      return cubit;
    },
    act: (cubit) => cubit.setStatusFilter(InspectionSyncStatus.failed),
    expect: () => [
      const InspectionsListState(
        status: InspectionsListStatus.loading,
        statusFilter: InspectionSyncStatus.failed,
      ),
      InspectionsListState(
        status: InspectionsListStatus.success,
        statusFilter: InspectionSyncStatus.failed,
        inspections: [testItem],
      ),
    ],
  );

  blocTest<InspectionsListCubit, InspectionsListState>(
    'retries failed inspection and reloads list',
    build: () {
      when(() => retryFailedInspectionUseCase('client-123'))
          .thenAnswer((_) async => appSuccess(testItem.inspection));
      when(() => getLocalInspectionsUseCase(status: any(named: 'status')))
          .thenAnswer((_) async => appSuccess([testItem]));
      return cubit;
    },
    act: (cubit) => cubit.retryInspection('client-123'),
    expect: () => [
      const InspectionsListState(
        retryingClientId: 'client-123',
      ),
      const InspectionsListState(
        actionFeedbackMessage: 'Inspeção reenviada para sincronização.',
        actionFeedbackSuccess: true,
      ),
      InspectionsListState(
        status: InspectionsListStatus.success,
        inspections: [testItem],
        actionFeedbackMessage: 'Inspeção reenviada para sincronização.',
        actionFeedbackSuccess: true,
      ),
    ],
  );

  blocTest<InspectionsListCubit, InspectionsListState>(
    'emits retry failure feedback when retry fails',
    build: () {
      when(() => retryFailedInspectionUseCase('client-123'))
          .thenAnswer((_) async => appFailure(const CacheFailure()));
      return cubit;
    },
    act: (cubit) => cubit.retryInspection('client-123'),
    expect: () => [
      const InspectionsListState(
        retryingClientId: 'client-123',
      ),
      const InspectionsListState(
        actionFeedbackMessage: 'Não foi possível acessar os dados locais.',
        actionFeedbackSuccess: false,
      ),
    ],
  );

  blocTest<InspectionsListCubit, InspectionsListState>(
    'refresh reloads inspections',
    build: () {
      when(() => getLocalInspectionsUseCase(status: any(named: 'status')))
          .thenAnswer((_) async => appSuccess([testItem]));
      return cubit;
    },
    seed: () => const InspectionsListState(
      status: InspectionsListStatus.success,
      inspections: [],
    ),
    act: (cubit) => cubit.refresh(),
    expect: () => [
      const InspectionsListState(
        status: InspectionsListStatus.success,
        inspections: [],
        isRefreshing: true,
      ),
      InspectionsListState(
        status: InspectionsListStatus.success,
        inspections: [testItem],
      ),
    ],
  );
}
