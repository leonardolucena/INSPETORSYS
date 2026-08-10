import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/components/app_drawer_app_bar_leading.dart';
import 'package:inspetorsys/components/states/app_empty_state.dart';
import 'package:inspetorsys/components/states/app_error_state.dart';
import 'package:inspetorsys/core/feedback/app_snackbar.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/core/router/app_routes.dart';
import 'package:inspetorsys/features/inspections/domain/entities/local_inspection_list_item.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspections_list_cubit.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspections_list_state.dart';
import 'package:inspetorsys/features/inspections/presentation/widgets/inspection_list_card.dart';
import 'package:inspetorsys/features/inspections/presentation/widgets/inspection_list_card_shimmer.dart';
import 'package:inspetorsys/features/inspections/presentation/widgets/inspection_status_filter_bar.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_cubit.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_state.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_orders_drawer.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class InspectionsListPage extends StatefulWidget {
  const InspectionsListPage({super.key});

  @override
  State<InspectionsListPage> createState() => _InspectionsListPageState();
}

class _InspectionsListPageState extends State<InspectionsListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<InspectionsListCubit>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InspectionsListCubit, InspectionsListState>(
          listenWhen: (previous, current) =>
              previous.actionFeedbackMessage != current.actionFeedbackMessage &&
              current.actionFeedbackMessage != null,
          listener: (context, state) {
            final message = state.actionFeedbackMessage!;
            final inspectionsCubit = context.read<InspectionsListCubit>();
            final syncCubit = context.read<SyncCubit>();

            if (state.actionFeedbackSuccess) {
              AppSnackbar.success(context, message);
              unawaited(syncCubit.syncNow());
            } else {
              AppSnackbar.error(context, message);
            }
            inspectionsCubit.clearActionFeedback();
          },
        ),
        BlocListener<SyncCubit, SyncState>(
          listenWhen: (previous, current) =>
              previous.operationStatus == SyncOperationStatus.syncing &&
              current.operationStatus == SyncOperationStatus.idle &&
              current.lastResult != null,
          listener: (context, state) {
            unawaited(context.read<InspectionsListCubit>().refresh());
          },
        ),
      ],
      child: BlocBuilder<InspectionsListCubit, InspectionsListState>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final listBackgroundColor = isDark
              ? AppColors.backgroundCardDark
              : AppColors.listScreenBackgroundLight;

          return Scaffold(
            backgroundColor: listBackgroundColor,
            drawer: const WorkOrdersDrawer(),
            appBar: AppDrawerAppBar(
              title: 'Histórico de inspeções',
              backgroundColor: listBackgroundColor,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.cardPadding,
                    AppSizes.cardPadding,
                    AppSizes.cardPadding,
                    AppSizes.spacingSm,
                  ),
                  child: InspectionStatusFilterBar(
                    selectedStatus: state.statusFilter,
                    onStatusSelected:
                        context.read<InspectionsListCubit>().setStatusFilter,
                  ),
                ),
                Expanded(child: _buildBody(context, state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, InspectionsListState state) {
    return switch (state.status) {
      InspectionsListStatus.initial ||
      InspectionsListStatus.loading =>
        Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: const InspectionListShimmer(),
        ),
      InspectionsListStatus.failure => Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: AppErrorState(
            message: state.errorMessage ??
                'Não foi possível carregar as inspeções locais.',
            onRetry: () => context.read<InspectionsListCubit>().load(),
          ),
        ),
      InspectionsListStatus.empty => Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: AppEmptyState(
            title: 'Nenhuma inspeção encontrada',
            message: state.statusFilter == null
                ? 'Você ainda não registrou inspeções neste dispositivo.'
                : 'Nenhuma inspeção com o status selecionado.',
            actionLabel: 'Atualizar',
            onAction: () => context.read<InspectionsListCubit>().refresh(),
          ),
        ),
      InspectionsListStatus.success => RefreshIndicator(
          onRefresh: () => context.read<InspectionsListCubit>().refresh(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(AppSizes.cardPadding),
            children: [
              for (final item in state.inspections)
                InspectionListCard(
                  item: item,
                  invertedSurface: true,
                  isRetrying:
                      state.retryingClientId == item.inspection.clientId,
                  onTap: () => _openInspection(context, item),
                  onRetry: item.inspection.status ==
                          InspectionSyncStatus.failed
                      ? () => context
                          .read<InspectionsListCubit>()
                          .retryInspection(item.inspection.clientId)
                      : null,
                ),
            ],
          ),
        ),
    };
  }

  Future<void> _openInspection(
    BuildContext context,
    LocalInspectionListItem item,
  ) async {
    final inspection = item.inspection;
    final status = inspection.status;

    if (status != InspectionSyncStatus.draft &&
        status != InspectionSyncStatus.failed) {
      AppSnackbar.info(
        context,
        'Esta inspeção já foi concluída e não pode ser editada.',
      );
      return;
    }

    await context.push(
      AppRoutes.inspectionFormPath(
        inspection.workOrderId,
        code: item.workOrderCode,
        clientId: inspection.clientId,
      ),
    );

    if (!context.mounted) {
      return;
    }

    await context.read<InspectionsListCubit>().refresh();
  }
}
