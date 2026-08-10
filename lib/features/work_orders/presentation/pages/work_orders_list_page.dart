import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/components/states/app_empty_state.dart';
import 'package:inspetorsys/components/states/app_error_state.dart';
import 'package:inspetorsys/components/work_order_code_search_field.dart';
import 'package:inspetorsys/core/feedback/app_snackbar.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/core/router/app_routes.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_state.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_card.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_card_shimmer.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_status_filter_bar.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_orders_drawer.dart';
import 'package:inspetorsys/l10n/app_localizations.dart';
import 'package:inspetorsys/theme/app_surface_colors.dart';

class WorkOrdersListPage extends StatefulWidget {
  const WorkOrdersListPage({super.key});

  @override
  State<WorkOrdersListPage> createState() => _WorkOrdersListPageState();
}

class _WorkOrdersListPageState extends State<WorkOrdersListPage> {
  late final TextEditingController _codeSearchController;

  @override
  void initState() {
    super.initState();
    _codeSearchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<WorkOrdersListCubit>().load();
      context.read<SyncCubit>().refreshPendingCount();
    });
  }

  @override
  void dispose() {
    _codeSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WorkOrdersListCubit, WorkOrdersListState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage &&
              current.errorMessage != null &&
              current.status == WorkOrdersListStatus.success,
          listener: (context, state) {
            AppSnackbar.error(
              context,
              localizeFailureMessage(context.l10n, state.errorMessage!),
            );
          },
        ),
      ],
      child: BlocBuilder<WorkOrdersListCubit, WorkOrdersListState>(
        builder: (context, state) {
          final l10n = context.l10n;
          final listBackgroundColor = AppSurfaceColors.screenBackground(context);

          return Scaffold(
            backgroundColor: listBackgroundColor,
            drawer: const WorkOrdersDrawer(),
            appBar: AppBar(
              backgroundColor: listBackgroundColor,
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              title: Text(l10n.workOrdersTitle),
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
                  child: WorkOrderStatusFilterBar(
                    selectedStatus: state.statusFilter,
                    onStatusSelected:
                        context.read<WorkOrdersListCubit>().setStatusFilter,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.cardPadding,
                    0,
                    AppSizes.cardPadding,
                    AppSizes.spacingSm,
                  ),
                  child: WorkOrderCodeSearchField(
                    controller: _codeSearchController,
                    onChanged: context.read<WorkOrdersListCubit>().setCodeSearchQuery,
                  ),
                ),
                Expanded(child: _buildBody(context, state, l10n)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WorkOrdersListState state,
    AppLocalizations l10n,
  ) {
    return switch (state.status) {
      WorkOrdersListStatus.initial ||
      WorkOrdersListStatus.loading =>
        Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: const WorkOrderListShimmer(),
        ),
      WorkOrdersListStatus.failure => Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: AppErrorState(
            message: localizeFailureMessage(
              l10n,
              state.errorMessage ?? l10n.workOrdersLoadError,
            ),
            onRetry: () => context.read<WorkOrdersListCubit>().load(),
          ),
        ),
      WorkOrdersListStatus.empty => Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: AppEmptyState(
            title: l10n.workOrdersEmptyTitle,
            message: state.statusFilter == null
                ? l10n.workOrdersEmptyMessageAll
                : l10n.workOrdersEmptyMessageFiltered,
            actionLabel: l10n.refreshAction,
            onAction: () => context.read<WorkOrdersListCubit>().refresh(),
          ),
        ),
      WorkOrdersListStatus.success =>
        state.visibleWorkOrders.isEmpty && state.hasActiveCodeSearch
            ? Padding(
                padding: EdgeInsets.all(AppSizes.cardPadding),
                child: AppEmptyState(
                  title: l10n.workOrdersEmptyTitle,
                  message: l10n.workOrdersEmptyMessageSearch,
                ),
              )
            : RefreshIndicator(
          onRefresh: () => context.read<WorkOrdersListCubit>().refresh(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(AppSizes.cardPadding),
            children: [
              for (final workOrder in state.visibleWorkOrders)
                WorkOrderCard(
                  workOrder: workOrder,
                  invertedSurface: true,
                  onTap: () => context.push(
                    AppRoutes.workOrderDetailPath(workOrder.id),
                  ),
                ),
            ],
          ),
        ),
    };
  }
}
