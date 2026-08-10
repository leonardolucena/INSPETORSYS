import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/core/router/app_routes.dart';
import 'package:inspetorsys/core/router/go_router_refresh_stream.dart';
import 'package:inspetorsys/core/di/injection.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/login_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/pages/login_page.dart';
import 'package:inspetorsys/features/auth/presentation/pages/splash_page.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_form_cubit.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspections_list_cubit.dart';
import 'package:inspetorsys/features/inspections/presentation/pages/inspection_form_page.dart';
import 'package:inspetorsys/features/inspections/presentation/pages/inspections_list_page.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_order_detail_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/pages/work_order_detail_page.dart';
import 'package:inspetorsys/features/work_orders/presentation/pages/work_orders_list_page.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppRouter {
  AppRouter(this._authSessionCubit);

  final AuthSessionCubit _authSessionCubit;

  String get _initialLocation {
    return switch (_authSessionCubit.state.status) {
      AuthSessionStatus.unknown => AppRoutes.splash,
      AuthSessionStatus.authenticated => AppRoutes.home,
      AuthSessionStatus.unauthenticated => AppRoutes.login,
    };
  }

  late final GoRouterRefreshStream _refreshListenable =
      GoRouterRefreshStream(_authSessionCubit.stream);

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: _initialLocation,
    refreshListenable: _refreshListenable,
    redirect: _redirect,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<WorkOrdersListCubit>(),
          child: const WorkOrdersListPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.workOrderDetail,
        builder: (context, state) {
          final workOrderId = state.pathParameters['id']!;

          return BlocProvider(
            create: (_) => getIt<WorkOrderDetailCubit>(),
            child: WorkOrderDetailPage(workOrderId: workOrderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.inspectionsHistory,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<InspectionsListCubit>(),
          child: const InspectionsListPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.inspectionForm,
        builder: (context, state) {
          final workOrderId = state.pathParameters['workOrderId']!;
          final workOrderCode = state.uri.queryParameters['code'];
          final inspectionClientId = state.uri.queryParameters['clientId'];

          return BlocProvider(
            create: (_) => getIt<InspectionFormCubit>(
              param1: workOrderId,
              param2: inspectionClientId,
            ),
            child: InspectionFormPage(
              workOrderId: workOrderId,
              workOrderCode: workOrderCode,
            ),
          );
        },
      ),
    ],
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final sessionStatus = _authSessionCubit.state.status;
    final location = state.matchedLocation;

    if (sessionStatus == AuthSessionStatus.unknown) {
      return location == AppRoutes.splash ? null : AppRoutes.splash;
    }

    if (!_authSessionCubit.state.isAuthenticated) {
      return location == AppRoutes.login ? null : AppRoutes.login;
    }

    if (location == AppRoutes.splash || location == AppRoutes.login) {
      return AppRoutes.home;
    }

    return null;
  }
}
