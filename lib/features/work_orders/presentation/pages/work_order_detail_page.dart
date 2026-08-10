import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspetorsys/components/accent_underline_text.dart';
import 'package:inspetorsys/components/app_drawer_app_bar_leading.dart';
import 'package:inspetorsys/components/app_map.dart';
import 'package:inspetorsys/components/card.dart';
import 'package:inspetorsys/components/elevated_button.dart';
import 'package:inspetorsys/components/states/app_error_state.dart';
import 'package:inspetorsys/core/maps/app_map_point.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/core/router/app_routes.dart';
import 'package:inspetorsys/core/utils/app_date_formatter.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_order_detail_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_order_detail_state.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_badge.dart';
import 'package:inspetorsys/components/states/screen_loading_shimmers.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_orders_drawer.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class WorkOrderDetailPage extends StatefulWidget {
  const WorkOrderDetailPage({
    super.key,
    required this.workOrderId,
  });

  final String workOrderId;

  @override
  State<WorkOrderDetailPage> createState() => _WorkOrderDetailPageState();
}

class _WorkOrderDetailPageState extends State<WorkOrderDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<WorkOrderDetailCubit>().load(widget.workOrderId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkOrderDetailCubit, WorkOrderDetailState>(
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final screenBackgroundColor = isDark
            ? AppColors.backgroundCardDark
            : AppColors.listScreenBackgroundLight;

        return Scaffold(
          backgroundColor: screenBackgroundColor,
          drawer: const WorkOrdersDrawer(),
          appBar: AppDrawerAppBar(
            title: 'Detalhe da OS',
            backgroundColor: screenBackgroundColor,
          ),
          body: switch (state.status) {
            WorkOrderDetailStatus.initial ||
            WorkOrderDetailStatus.loading =>
              Padding(
                padding: EdgeInsets.all(AppSizes.cardPadding),
                child: const WorkOrderDetailShimmer(),
              ),
            WorkOrderDetailStatus.failure => Padding(
                padding: EdgeInsets.all(AppSizes.cardPadding),
                child: AppErrorState(
                  message: state.errorMessage ??
                      'Não foi possível carregar a ordem de serviço.',
                  onRetry: () => context
                      .read<WorkOrderDetailCubit>()
                      .load(widget.workOrderId),
                ),
              ),
            WorkOrderDetailStatus.success => _buildContent(context, state),
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, WorkOrderDetailState state) {
    final workOrder = state.workOrder!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDark ? AppColors.backgroundDark : AppColors.listScreenCardLight;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSizes.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            backgroundColor: cardBackgroundColor,
            showBorder: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppAccentUnderlineText(label: workOrder.code),
                    ),
                    SizedBox(width: AppSizes.spacingSm),
                    Wrap(
                      spacing: AppSizes.spacingXs,
                      runSpacing: AppSizes.spacingXs,
                      alignment: WrapAlignment.end,
                      children: [
                        WorkOrderPriorityBadge(priority: workOrder.priority),
                        WorkOrderStatusBadge(status: workOrder.status),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spacingXs),
                Text(
                  workOrder.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (workOrder.description?.isNotEmpty ?? false) ...[
                  SizedBox(height: AppSizes.spacingSm),
                  _DetailRow(
                    label: 'Descrição:',
                    value: workOrder.description!,
                  ),
                ],
                SizedBox(height: AppSizes.spacingXs),
                _DetailRow(
                  label: 'Endereço:',
                  value: workOrder.address,
                ),
                if (workOrder.notes?.isNotEmpty ?? false) ...[
                  SizedBox(height: AppSizes.spacingXs),
                  _DetailRow(
                    label: 'Anotações:',
                    value: workOrder.notes!,
                  ),
                ],
                if (workOrder.scheduledAt != null) ...[
                  SizedBox(height: AppSizes.spacingXs),
                  _DetailRow(
                    label: 'Agendada para',
                    value: workOrder.scheduledAt!.toDateTimeLabel,
                  ),
                ],
                SizedBox(height: AppSizes.spacingXs),
                _DetailRow(
                  label: 'Atualizada em',
                  value: workOrder.updatedAt.toDateTimeLabel,
                ),
              ],
            ),
          ),
          if (workOrder.latitude != null && workOrder.longitude != null) ...[
            SizedBox(height: AppSizes.spacingMd),
            AppCard(
              backgroundColor: cardBackgroundColor,
              showBorder: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Localização',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppSizes.spacingSm),
                  AppMap(
                    markerColor: AppColors.statusDanger,
                    controlIconColor: AppColors.primaryTextColorLight,
                    points: [
                      AppMapPoint(
                        latitude: workOrder.latitude!,
                        longitude: workOrder.longitude!,
                        label: workOrder.address,
                        type: AppMapPointType.workOrder,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: AppSizes.spacingLg),
          AppElevatedButton(
            label: 'Nova inspeção',
            icon: Icons.assignment_outlined,
            onPressed: () {
              context.push(
                AppRoutes.inspectionFormPath(
                  workOrder.id,
                  code: workOrder.code.isNotEmpty ? workOrder.code : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
