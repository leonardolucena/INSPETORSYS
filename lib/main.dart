import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/core/di/injection.dart';
import 'package:inspetorsys/core/maps/map_tile_cache_service.dart';
import 'package:inspetorsys/core/router/app_router.dart';
import 'package:inspetorsys/core/sync/background_sync_scheduler.dart';
import 'package:inspetorsys/core/utils/app_date_formatter.dart';
import 'package:inspetorsys/core/connectivity/presentation/cubit/connection_status_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/current_user_cubit.dart';
import 'package:inspetorsys/core/feedback/app_snackbar.dart';
import 'package:inspetorsys/core/theme/presentation/cubit/theme_cubit.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_cubit.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_state.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/prefetch_work_orders_use_case.dart';
import 'package:inspetorsys/theme/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDateFormatter.initialize();
  await BackgroundSyncScheduler.initialize();
  await configureDependencies();
  await getIt<MapTileCacheService>().initialize();

  final authSessionCubit = getIt<AuthSessionCubit>();
  final syncCubit = getIt<SyncCubit>();
  final connectionStatusCubit = getIt<ConnectionStatusCubit>();
  final currentUserCubit = getIt<CurrentUserCubit>();
  final themeCubit = getIt<ThemeCubit>();
  await themeCubit.load();

  final router = getIt<AppRouter>().router;

  authSessionCubit.stream.listen((state) {
    _onAuthSessionChanged(
      state,
      syncCubit,
      connectionStatusCubit,
      currentUserCubit,
    );
  });

  runApp(
    MyApp(
      router: router,
      authSessionCubit: authSessionCubit,
      syncCubit: syncCubit,
      connectionStatusCubit: connectionStatusCubit,
      currentUserCubit: currentUserCubit,
      themeCubit: themeCubit,
    ),
  );

  // Validate session after the first frame so the debugger can attach and the
  // splash paints while auth/network work runs.
  unawaited(authSessionCubit.checkSession());
}

void _onAuthSessionChanged(
  AuthSessionState state,
  SyncCubit syncCubit,
  ConnectionStatusCubit connectionStatusCubit,
  CurrentUserCubit currentUserCubit,
) {
  if (state.status == AuthSessionStatus.unknown) {
    return;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _handleAuthSessionChange(
      state,
      syncCubit,
      connectionStatusCubit,
      currentUserCubit,
    );
  });
}

void _handleAuthSessionChange(
  AuthSessionState state,
  SyncCubit syncCubit,
  ConnectionStatusCubit connectionStatusCubit,
  CurrentUserCubit currentUserCubit,
) {
  if (state.isAuthenticated) {
    connectionStatusCubit.startMonitoring();
    unawaited(currentUserCubit.load());
    unawaited(getIt<PrefetchWorkOrdersUseCase>()());
    unawaited(BackgroundSyncScheduler.registerPeriodicSync());
    Future<void>.delayed(const Duration(seconds: 2), () {
      syncCubit.startAutoSync();
    });
    return;
  }

  connectionStatusCubit.stopMonitoring();
  syncCubit.stopAutoSync();
  unawaited(BackgroundSyncScheduler.cancelSync());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.router,
    required this.authSessionCubit,
    required this.syncCubit,
    required this.connectionStatusCubit,
    required this.currentUserCubit,
    required this.themeCubit,
  });

  final GoRouter router;
  final AuthSessionCubit authSessionCubit;
  final SyncCubit syncCubit;
  final ConnectionStatusCubit connectionStatusCubit;
  final CurrentUserCubit currentUserCubit;
  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthSessionCubit>.value(value: authSessionCubit),
        BlocProvider<SyncCubit>.value(value: syncCubit),
        BlocProvider<ConnectionStatusCubit>.value(
          value: connectionStatusCubit,
        ),
        BlocProvider<CurrentUserCubit>.value(value: currentUserCubit),
        BlocProvider<ThemeCubit>.value(value: themeCubit),
      ],
      child: BlocListener<SyncCubit, SyncState>(
        listenWhen: (previous, current) =>
            previous.feedbackMessage != current.feedbackMessage &&
            current.feedbackMessage != null &&
            current.isManualTrigger,
        listener: (context, state) {
          final message = state.feedbackMessage!;
          if (state.isSuccessFeedback) {
            AppSnackbar.success(context, message);
          } else {
            AppSnackbar.error(context, message);
          }
        },
        child: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return MaterialApp.router(
                  title: 'InspetorSYS',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeMode,
                  scaffoldMessengerKey: AppSnackbar.messengerKey,
                  routerConfig: router,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
