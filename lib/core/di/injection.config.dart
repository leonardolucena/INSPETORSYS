// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:inspetorsys/core/connectivity/app_network_monitor.dart'
    as _i362;
import 'package:inspetorsys/core/connectivity/network_monitor.dart' as _i340;
import 'package:inspetorsys/core/connectivity/presentation/cubit/connection_status_cubit.dart'
    as _i993;
import 'package:inspetorsys/core/database/app_database.dart' as _i736;
import 'package:inspetorsys/core/di/app_module.dart' as _i224;
import 'package:inspetorsys/core/image/app_image_picker_service.dart' as _i724;
import 'package:inspetorsys/core/image/flutter_image_compressor.dart' as _i428;
import 'package:inspetorsys/core/image/image_compressor.dart' as _i14;
import 'package:inspetorsys/core/image/image_picker_service.dart' as _i14;
import 'package:inspetorsys/core/image/inspection_photo_service.dart' as _i366;
import 'package:inspetorsys/core/locale/locale_preference_storage.dart'
    as _i569;
import 'package:inspetorsys/core/locale/presentation/cubit/locale_cubit.dart'
    as _i437;
import 'package:inspetorsys/core/locale/shared_prefs_locale_preference_storage.dart'
    as _i793;
import 'package:inspetorsys/core/location/geo_distance_calculator.dart' as _i94;
import 'package:inspetorsys/core/location/geolocator_location_service.dart'
    as _i247;
import 'package:inspetorsys/core/location/location_service.dart' as _i566;
import 'package:inspetorsys/core/maps/fmtc_map_tile_cache_service.dart'
    as _i439;
import 'package:inspetorsys/core/maps/map_tile_cache_service.dart' as _i349;
import 'package:inspetorsys/core/network/dio_client.dart' as _i102;
import 'package:inspetorsys/core/notifications/flutter_local_notification_service.dart'
    as _i367;
import 'package:inspetorsys/core/notifications/notification_service.dart'
    as _i417;
import 'package:inspetorsys/core/permissions/app_permission_service.dart'
    as _i474;
import 'package:inspetorsys/core/permissions/permission_service.dart' as _i544;
import 'package:inspetorsys/core/router/app_router.dart' as _i217;
import 'package:inspetorsys/core/session/session_token_provider.dart' as _i4;
import 'package:inspetorsys/core/storage/app_paths.dart' as _i428;
import 'package:inspetorsys/core/storage/secure_token_storage.dart' as _i589;
import 'package:inspetorsys/core/storage/token_storage.dart' as _i288;
import 'package:inspetorsys/core/theme/contrast_preference_storage.dart'
    as _i568;
import 'package:inspetorsys/core/theme/presentation/cubit/high_contrast_cubit.dart'
    as _i555;
import 'package:inspetorsys/core/theme/presentation/cubit/theme_cubit.dart'
    as _i969;
import 'package:inspetorsys/core/theme/shared_prefs_contrast_preference_storage.dart'
    as _i566;
import 'package:inspetorsys/core/theme/shared_prefs_theme_preference_storage.dart'
    as _i286;
import 'package:inspetorsys/core/theme/theme_preference_storage.dart' as _i242;
import 'package:inspetorsys/core/utils/app_uuid_generator.dart' as _i911;
import 'package:inspetorsys/core/utils/uuid_generator.dart' as _i397;
import 'package:inspetorsys/features/auth/data/datasources/auth_local_data_source.dart'
    as _i949;
import 'package:inspetorsys/features/auth/data/datasources/auth_local_data_source_impl.dart'
    as _i592;
import 'package:inspetorsys/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i223;
import 'package:inspetorsys/features/auth/data/datasources/auth_remote_data_source_impl.dart'
    as _i723;
import 'package:inspetorsys/features/auth/data/repositories/auth_repository_impl.dart'
    as _i767;
import 'package:inspetorsys/features/auth/domain/repositories/auth_repository.dart'
    as _i97;
import 'package:inspetorsys/features/auth/domain/usecases/get_current_user_use_case.dart'
    as _i51;
import 'package:inspetorsys/features/auth/domain/usecases/login_use_case.dart'
    as _i456;
import 'package:inspetorsys/features/auth/domain/usecases/logout_use_case.dart'
    as _i841;
import 'package:inspetorsys/features/auth/domain/usecases/validate_session_use_case.dart'
    as _i861;
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_cubit.dart'
    as _i485;
import 'package:inspetorsys/features/auth/presentation/cubit/current_user_cubit.dart'
    as _i366;
import 'package:inspetorsys/features/auth/presentation/cubit/login_cubit.dart'
    as _i778;
import 'package:inspetorsys/features/inspections/data/datasources/drift_inspection_form_schema_cache_data_source.dart'
    as _i54;
import 'package:inspetorsys/features/inspections/data/datasources/inspection_form_schema_cache_data_source.dart'
    as _i865;
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source.dart'
    as _i806;
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source_impl.dart'
    as _i322;
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source.dart'
    as _i80;
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source_impl.dart'
    as _i656;
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source.dart'
    as _i397;
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source_impl.dart'
    as _i307;
import 'package:inspetorsys/features/inspections/data/repositories/inspection_repository_impl.dart'
    as _i180;
import 'package:inspetorsys/features/inspections/domain/repositories/inspection_repository.dart'
    as _i518;
import 'package:inspetorsys/features/inspections/domain/usecases/capture_inspection_location_use_case.dart'
    as _i650;
import 'package:inspetorsys/features/inspections/domain/usecases/capture_inspection_photo_use_case.dart'
    as _i519;
import 'package:inspetorsys/features/inspections/domain/usecases/complete_inspection_use_case.dart'
    as _i963;
import 'package:inspetorsys/features/inspections/domain/usecases/get_cached_inspections_use_case.dart'
    as _i360;
import 'package:inspetorsys/features/inspections/domain/usecases/get_inspection_by_client_id_use_case.dart'
    as _i492;
import 'package:inspetorsys/features/inspections/domain/usecases/get_inspection_form_schema_use_case.dart'
    as _i1053;
import 'package:inspetorsys/features/inspections/domain/usecases/get_inspections_use_case.dart'
    as _i424;
import 'package:inspetorsys/features/inspections/domain/usecases/get_local_inspection_by_client_id_use_case.dart'
    as _i785;
import 'package:inspetorsys/features/inspections/domain/usecases/get_local_inspections_use_case.dart'
    as _i477;
import 'package:inspetorsys/features/inspections/domain/usecases/get_pending_inspections_count_use_case.dart'
    as _i1052;
import 'package:inspetorsys/features/inspections/domain/usecases/prefetch_inspections_use_case.dart'
    as _i368;
import 'package:inspetorsys/features/inspections/domain/usecases/retry_failed_inspection_use_case.dart'
    as _i630;
import 'package:inspetorsys/features/inspections/domain/usecases/save_inspection_draft_use_case.dart'
    as _i1057;
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_detail_cubit.dart'
    as _i392;
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_form_cubit.dart'
    as _i420;
import 'package:inspetorsys/features/inspections/presentation/cubit/inspections_list_cubit.dart'
    as _i692;
import 'package:inspetorsys/features/sync/domain/services/inspection_sync_service.dart'
    as _i983;
import 'package:inspetorsys/features/sync/domain/usecases/sync_pending_inspections_use_case.dart'
    as _i105;
import 'package:inspetorsys/features/sync/presentation/cubit/sync_cubit.dart'
    as _i755;
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source.dart'
    as _i917;
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source_impl.dart'
    as _i772;
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_remote_data_source.dart'
    as _i807;
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_remote_data_source_impl.dart'
    as _i531;
import 'package:inspetorsys/features/work_orders/data/repositories/work_order_repository_impl.dart'
    as _i246;
import 'package:inspetorsys/features/work_orders/domain/repositories/work_order_repository.dart'
    as _i367;
import 'package:inspetorsys/features/work_orders/domain/usecases/get_cached_work_orders_use_case.dart'
    as _i738;
import 'package:inspetorsys/features/work_orders/domain/usecases/get_work_order_by_id_use_case.dart'
    as _i309;
import 'package:inspetorsys/features/work_orders/domain/usecases/get_work_orders_use_case.dart'
    as _i622;
import 'package:inspetorsys/features/work_orders/domain/usecases/prefetch_work_orders_use_case.dart'
    as _i142;
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_order_detail_cubit.dart'
    as _i976;
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_cubit.dart'
    as _i703;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.lazySingletonAsync<_i428.AppPaths>(
      () => appModule.appPaths(),
      preResolve: true,
    );
    gh.lazySingleton<_i895.Connectivity>(() => appModule.connectivity());
    gh.lazySingleton<_i183.ImagePicker>(() => appModule.imagePicker());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => appModule.flutterSecureStorage(),
    );
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i94.GeoDistanceCalculator>(
      () => _i94.GeoDistanceCalculator(),
    );
    gh.lazySingleton<_i736.AppDatabase>(
      () => appModule.appDatabase(gh<_i428.AppPaths>()),
    );
    gh.lazySingleton<_i397.SyncQueueLocalDataSource>(
      () => _i307.SyncQueueLocalDataSourceImpl(gh<_i736.AppDatabase>()),
    );
    gh.lazySingleton<_i14.ImageCompressor>(
      () => _i428.FlutterImageCompressor(),
    );
    gh.lazySingleton<_i949.AuthLocalDataSource>(
      () => _i592.AuthLocalDataSourceImpl(gh<_i736.AppDatabase>()),
    );
    gh.lazySingleton<_i865.InspectionFormSchemaCacheDataSource>(
      () => _i54.DriftInspectionFormSchemaCacheDataSource(
        gh<_i736.AppDatabase>(),
      ),
    );
    gh.lazySingleton<_i161.InternetConnection>(
      () => appModule.internetConnection(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i544.PermissionService>(
      () => _i474.AppPermissionService(),
    );
    gh.lazySingleton<_i288.TokenStorage>(
      () => _i589.SecureTokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i242.ThemePreferenceStorage>(
      () => _i286.SharedPrefsThemePreferenceStorage(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i806.InspectionLocalDataSource>(
      () => _i322.InspectionLocalDataSourceImpl(gh<_i736.AppDatabase>()),
    );
    gh.lazySingleton<_i569.LocalePreferenceStorage>(
      () => _i793.SharedPrefsLocalePreferenceStorage(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i917.WorkOrderLocalDataSource>(
      () => _i772.WorkOrderLocalDataSourceImpl(gh<_i736.AppDatabase>()),
    );
    gh.lazySingleton<_i349.MapTileCacheService>(
      () => _i439.FmtcMapTileCacheService(),
    );
    gh.lazySingleton<_i568.ContrastPreferenceStorage>(
      () => _i566.SharedPrefsContrastPreferenceStorage(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i397.UuidGenerator>(() => const _i911.AppUuidGenerator());
    gh.lazySingleton<_i555.HighContrastCubit>(
      () => _i555.HighContrastCubit(gh<_i568.ContrastPreferenceStorage>()),
    );
    gh.lazySingleton<_i4.SessionTokenProvider>(
      () => _i4.SessionTokenProvider(gh<_i288.TokenStorage>()),
    );
    gh.lazySingleton<_i437.LocaleCubit>(
      () => _i437.LocaleCubit(gh<_i569.LocalePreferenceStorage>()),
    );
    gh.lazySingleton<_i566.LocationService>(
      () => _i247.GeolocatorLocationService(gh<_i544.PermissionService>()),
    );
    gh.lazySingleton<_i14.ImagePickerService>(
      () => _i724.AppImagePickerService(
        gh<_i544.PermissionService>(),
        gh<_i183.ImagePicker>(),
      ),
    );
    gh.lazySingleton<_i366.InspectionPhotoService>(
      () => _i366.InspectionPhotoService(
        gh<_i428.AppPaths>(),
        gh<_i14.ImagePickerService>(),
        gh<_i14.ImageCompressor>(),
      ),
    );
    gh.lazySingleton<_i417.NotificationService>(
      () => _i367.FlutterLocalNotificationService(
        gh<_i569.LocalePreferenceStorage>(),
      ),
    );
    gh.factory<_i650.CaptureInspectionLocationUseCase>(
      () => _i650.CaptureInspectionLocationUseCase(gh<_i566.LocationService>()),
    );
    gh.factory<_i841.LogoutUseCase>(
      () => _i841.LogoutUseCase(
        gh<_i4.SessionTokenProvider>(),
        gh<_i949.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i969.ThemeCubit>(
      () => _i969.ThemeCubit(gh<_i242.ThemePreferenceStorage>()),
    );
    gh.lazySingleton<_i340.NetworkMonitor>(
      () => _i362.AppNetworkMonitor(
        gh<_i895.Connectivity>(),
        gh<_i161.InternetConnection>(),
      ),
    );
    gh.lazySingleton<_i102.DioClient>(
      () => appModule.dioClient(gh<_i4.SessionTokenProvider>()),
    );
    gh.lazySingleton<_i80.InspectionRemoteDataSource>(
      () => _i656.InspectionRemoteDataSourceImpl(gh<_i102.DioClient>()),
    );
    gh.factory<_i519.CaptureInspectionPhotoUseCase>(
      () => _i519.CaptureInspectionPhotoUseCase(
        gh<_i366.InspectionPhotoService>(),
      ),
    );
    gh.lazySingleton<_i223.AuthRemoteDataSource>(
      () => _i723.AuthRemoteDataSourceImpl(gh<_i102.DioClient>()),
    );
    gh.lazySingleton<_i993.ConnectionStatusCubit>(
      () => _i993.ConnectionStatusCubit(gh<_i340.NetworkMonitor>()),
    );
    gh.lazySingleton<_i807.WorkOrderRemoteDataSource>(
      () => _i531.WorkOrderRemoteDataSourceImpl(gh<_i102.DioClient>()),
    );
    gh.lazySingleton<_i983.InspectionSyncService>(
      () => _i983.InspectionSyncService(
        gh<_i397.SyncQueueLocalDataSource>(),
        gh<_i806.InspectionLocalDataSource>(),
        gh<_i80.InspectionRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i518.InspectionRepository>(
      () => _i180.InspectionRepositoryImpl(
        gh<_i806.InspectionLocalDataSource>(),
        gh<_i80.InspectionRemoteDataSource>(),
        gh<_i397.SyncQueueLocalDataSource>(),
        gh<_i917.WorkOrderLocalDataSource>(),
        gh<_i340.NetworkMonitor>(),
        gh<_i397.UuidGenerator>(),
      ),
    );
    gh.lazySingleton<_i97.AuthRepository>(
      () => _i767.AuthRepositoryImpl(gh<_i223.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i367.WorkOrderRepository>(
      () => _i246.WorkOrderRepositoryImpl(
        gh<_i807.WorkOrderRemoteDataSource>(),
        gh<_i917.WorkOrderLocalDataSource>(),
        gh<_i865.InspectionFormSchemaCacheDataSource>(),
        gh<_i340.NetworkMonitor>(),
      ),
    );
    gh.factory<_i861.ValidateSessionUseCase>(
      () => _i861.ValidateSessionUseCase(
        gh<_i97.AuthRepository>(),
        gh<_i4.SessionTokenProvider>(),
        gh<_i841.LogoutUseCase>(),
      ),
    );
    gh.factory<_i142.PrefetchWorkOrdersUseCase>(
      () => _i142.PrefetchWorkOrdersUseCase(
        gh<_i367.WorkOrderRepository>(),
        gh<_i340.NetworkMonitor>(),
        gh<_i349.MapTileCacheService>(),
      ),
    );
    gh.factory<_i51.GetCurrentUserUseCase>(
      () => _i51.GetCurrentUserUseCase(gh<_i97.AuthRepository>()),
    );
    gh.factory<_i456.LoginUseCase>(
      () => _i456.LoginUseCase(gh<_i97.AuthRepository>()),
    );
    gh.lazySingleton<_i366.CurrentUserCubit>(
      () => _i366.CurrentUserCubit(gh<_i51.GetCurrentUserUseCase>()),
    );
    gh.factory<_i778.LoginCubit>(
      () => _i778.LoginCubit(gh<_i456.LoginUseCase>()),
    );
    gh.factory<_i105.SyncPendingInspectionsUseCase>(
      () => _i105.SyncPendingInspectionsUseCase(
        gh<_i983.InspectionSyncService>(),
      ),
    );
    gh.factory<_i738.GetCachedWorkOrdersUseCase>(
      () => _i738.GetCachedWorkOrdersUseCase(gh<_i367.WorkOrderRepository>()),
    );
    gh.factory<_i738.GetCachedWorkOrderByIdUseCase>(
      () =>
          _i738.GetCachedWorkOrderByIdUseCase(gh<_i367.WorkOrderRepository>()),
    );
    gh.factory<_i309.GetWorkOrderByIdUseCase>(
      () => _i309.GetWorkOrderByIdUseCase(gh<_i367.WorkOrderRepository>()),
    );
    gh.factory<_i622.GetWorkOrdersUseCase>(
      () => _i622.GetWorkOrdersUseCase(gh<_i367.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i485.AuthSessionCubit>(
      () => _i485.AuthSessionCubit(
        gh<_i4.SessionTokenProvider>(),
        gh<_i861.ValidateSessionUseCase>(),
        gh<_i841.LogoutUseCase>(),
      ),
    );
    gh.factory<_i963.CompleteInspectionUseCase>(
      () => _i963.CompleteInspectionUseCase(gh<_i518.InspectionRepository>()),
    );
    gh.factory<_i360.GetCachedInspectionsUseCase>(
      () => _i360.GetCachedInspectionsUseCase(gh<_i518.InspectionRepository>()),
    );
    gh.factory<_i360.GetCachedInspectionByClientIdUseCase>(
      () => _i360.GetCachedInspectionByClientIdUseCase(
        gh<_i518.InspectionRepository>(),
      ),
    );
    gh.factory<_i492.GetInspectionByClientIdUseCase>(
      () => _i492.GetInspectionByClientIdUseCase(
        gh<_i518.InspectionRepository>(),
      ),
    );
    gh.factory<_i424.GetInspectionsUseCase>(
      () => _i424.GetInspectionsUseCase(gh<_i518.InspectionRepository>()),
    );
    gh.factory<_i785.GetLocalInspectionByClientIdUseCase>(
      () => _i785.GetLocalInspectionByClientIdUseCase(
        gh<_i518.InspectionRepository>(),
      ),
    );
    gh.factory<_i477.GetLocalInspectionsUseCase>(
      () => _i477.GetLocalInspectionsUseCase(gh<_i518.InspectionRepository>()),
    );
    gh.factory<_i1052.GetPendingInspectionsCountUseCase>(
      () => _i1052.GetPendingInspectionsCountUseCase(
        gh<_i518.InspectionRepository>(),
      ),
    );
    gh.factory<_i630.RetryFailedInspectionUseCase>(
      () =>
          _i630.RetryFailedInspectionUseCase(gh<_i518.InspectionRepository>()),
    );
    gh.factory<_i1057.SaveInspectionDraftUseCase>(
      () => _i1057.SaveInspectionDraftUseCase(gh<_i518.InspectionRepository>()),
    );
    gh.factory<_i368.PrefetchInspectionsUseCase>(
      () => _i368.PrefetchInspectionsUseCase(
        gh<_i518.InspectionRepository>(),
        gh<_i340.NetworkMonitor>(),
      ),
    );
    gh.factory<_i1053.GetInspectionFormSchemaUseCase>(
      () => _i1053.GetInspectionFormSchemaUseCase(
        gh<_i367.WorkOrderRepository>(),
      ),
    );
    gh.factory<_i392.InspectionDetailCubit>(
      () => _i392.InspectionDetailCubit(
        gh<_i492.GetInspectionByClientIdUseCase>(),
        gh<_i360.GetCachedInspectionByClientIdUseCase>(),
        gh<_i738.GetCachedWorkOrderByIdUseCase>(),
        gh<_i340.NetworkMonitor>(),
      ),
    );
    gh.lazySingleton<_i755.SyncCubit>(
      () => _i755.SyncCubit(
        gh<_i105.SyncPendingInspectionsUseCase>(),
        gh<_i1052.GetPendingInspectionsCountUseCase>(),
        gh<_i142.PrefetchWorkOrdersUseCase>(),
        gh<_i368.PrefetchInspectionsUseCase>(),
        gh<_i340.NetworkMonitor>(),
      ),
    );
    gh.factory<_i692.InspectionsListCubit>(
      () => _i692.InspectionsListCubit(
        gh<_i424.GetInspectionsUseCase>(),
        gh<_i360.GetCachedInspectionsUseCase>(),
        gh<_i630.RetryFailedInspectionUseCase>(),
        gh<_i340.NetworkMonitor>(),
      ),
    );
    gh.factory<_i976.WorkOrderDetailCubit>(
      () => _i976.WorkOrderDetailCubit(
        gh<_i309.GetWorkOrderByIdUseCase>(),
        gh<_i738.GetCachedWorkOrderByIdUseCase>(),
        gh<_i340.NetworkMonitor>(),
      ),
    );
    gh.lazySingleton<_i217.AppRouter>(
      () => _i217.AppRouter(gh<_i485.AuthSessionCubit>()),
    );
    gh.factoryParam<_i420.InspectionFormCubit, String, String?>(
      (workOrderId, inspectionClientId) => _i420.InspectionFormCubit(
        gh<_i519.CaptureInspectionPhotoUseCase>(),
        gh<_i650.CaptureInspectionLocationUseCase>(),
        gh<_i1053.GetInspectionFormSchemaUseCase>(),
        gh<_i309.GetWorkOrderByIdUseCase>(),
        gh<_i785.GetLocalInspectionByClientIdUseCase>(),
        gh<_i1057.SaveInspectionDraftUseCase>(),
        gh<_i963.CompleteInspectionUseCase>(),
        gh<_i94.GeoDistanceCalculator>(),
        gh<_i566.LocationService>(),
        gh<_i544.PermissionService>(),
        workOrderId: workOrderId,
        inspectionClientId: inspectionClientId,
      ),
    );
    gh.factory<_i703.WorkOrdersListCubit>(
      () => _i703.WorkOrdersListCubit(
        gh<_i622.GetWorkOrdersUseCase>(),
        gh<_i738.GetCachedWorkOrdersUseCase>(),
        gh<_i340.NetworkMonitor>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i224.AppModule {}
