import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/components/states/app_empty_state.dart';
import 'package:inspetorsys/components/states/app_error_state.dart';
import 'package:inspetorsys/core/feedback/app_snackbar.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/core/router/app_routes.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_state.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_card.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_card_shimmer.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_status_filter_bar.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_orders_drawer.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class WorkOrdersListPage extends StatefulWidget {
  const WorkOrdersListPage({super.key});

  @override
  State<WorkOrdersListPage> createState() => _WorkOrdersListPageState();
}

class _WorkOrdersListPageState extends State<WorkOrdersListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<WorkOrdersListCubit>().load();
      context.read<SyncCubit>().refreshPendingCount();
    });
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
            AppSnackbar.error(context, state.errorMessage!);
          },
        ),
      ],
      child: BlocBuilder<WorkOrdersListCubit, WorkOrdersListState>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final listBackgroundColor = isDark
              ? AppColors.backgroundCardDark
              : AppColors.listScreenBackgroundLight;

          return Scaffold(
            backgroundColor: listBackgroundColor,
            drawer: const WorkOrdersDrawer(),
            appBar: AppBar(
              backgroundColor: listBackgroundColor,
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              title: const Text('Ordens de serviço'),
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
                Expanded(child: _buildBody(context, state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, WorkOrdersListState state) {
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
            message: state.errorMessage ??
                'Não foi possível carregar as ordens de serviço.',
            onRetry: () => context.read<WorkOrdersListCubit>().load(),
          ),
        ),
      WorkOrdersListStatus.empty => Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding),
          child: AppEmptyState(
            title: 'Nenhuma ordem de serviço',
            message: state.statusFilter == null
                ? 'Não há ordens de serviço disponíveis no momento.'
                : 'Nenhuma ordem com o filtro selecionado.',
            actionLabel: 'Atualizar',
            onAction: () => context.read<WorkOrdersListCubit>().refresh(),
          ),
        ),
      WorkOrdersListStatus.success => RefreshIndicator(
          onRefresh: () => context.read<WorkOrdersListCubit>().refresh(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(AppSizes.cardPadding),
            children: [
              for (final workOrder in state.workOrders)
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
