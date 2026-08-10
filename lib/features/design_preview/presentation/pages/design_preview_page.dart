import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/components/app_map.dart';
import 'package:inspetorsys/components/card.dart';
import 'package:inspetorsys/components/checkbox.dart';
import 'package:inspetorsys/components/elevated_button.dart';
import 'package:inspetorsys/components/inline_button.dart';
import 'package:inspetorsys/components/outline_button.dart';
import 'package:inspetorsys/components/radio.dart';
import 'package:inspetorsys/components/status_badge.dart';
import 'package:inspetorsys/components/states/app_empty_state.dart';
import 'package:inspetorsys/components/states/app_error_state.dart';
import 'package:inspetorsys/components/states/app_loading_state.dart';
import 'package:inspetorsys/components/switch.dart';
import 'package:inspetorsys/components/text_field.dart';
import 'package:inspetorsys/constants/app_assets.dart';
import 'package:inspetorsys/core/di/injection.dart';
import 'package:inspetorsys/core/feedback/app_snackbar.dart';
import 'package:inspetorsys/core/image/image_exception.dart';
import 'package:inspetorsys/core/image/inspection_photo_service.dart';
import 'package:inspetorsys/core/maps/app_map_point.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_badge.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DesignPreviewPage extends StatefulWidget {
  const DesignPreviewPage({super.key});

  @override
  State<DesignPreviewPage> createState() => _DesignPreviewPageState();
}

enum _PreviewState { loading, empty, error, content }

class _DesignPreviewPageState extends State<DesignPreviewPage> {
  bool _switchValue = false;
  int _radioValue = 0;
  bool _checkboxValue = false;
  _PreviewState _previewState = _PreviewState.content;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  String? _capturedPhotoPath;
  bool _isCapturingPhoto = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      _emailError = _emailController.text.contains('@')
          ? null
          : 'Informe um e-mail válido';
      _passwordError = _passwordController.text.length >= 6
          ? null
          : 'A senha deve ter no mínimo 6 caracteres';
    });
  }

  Future<void> _capturePhoto() async {
    setState(() => _isCapturingPhoto = true);

    try {
      final image = await getIt<InspectionPhotoService>().captureAndSave();

      if (!mounted) {
        return;
      }

      setState(() => _capturedPhotoPath = image.path);
      AppSnackbar.success(
        context,
        'Foto salva (${(image.sizeBytes / 1024).toStringAsFixed(0)} KB)',
      );
    } on ImageCaptureCancelledException {
      return;
    } on ImageException catch (error) {
      if (!mounted) {
        return;
      }

      AppSnackbar.error(context, error.message);
    } finally {
      if (mounted) {
        setState(() => _isCapturingPhoto = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InspetorSYS'),
        actions: [
          IconButton(
            tooltip: 'Sair',
            onPressed: () => context.read<AuthSessionCubit>().signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                AppAssets.logoInspetorsys,
                width: 60.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Card + Badges',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OS-2026-001',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: AppSizes.spacingXs),
                  Text(
                    'Inspeção de poste — Rua das Acácias',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: AppSizes.spacingSm),
                  Wrap(
                    spacing: AppSizes.spacingSm,
                    runSpacing: AppSizes.spacingSm,
                    children: const [
                      AppStatusBadge(status: AppSyncStatus.draft),
                      AppStatusBadge(status: AppSyncStatus.pending),
                      AppStatusBadge(status: AppSyncStatus.synced),
                      AppStatusBadge(status: AppSyncStatus.failed),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Badges de OS',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            Text(
              'Status',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: AppSizes.spacingXs),
            Wrap(
              spacing: AppSizes.spacingSm,
              runSpacing: AppSizes.spacingSm,
              children: const [
                WorkOrderStatusBadge(status: WorkOrderStatus.open),
                WorkOrderStatusBadge(status: WorkOrderStatus.inProgress),
                WorkOrderStatusBadge(status: WorkOrderStatus.done),
              ],
            ),
            SizedBox(height: AppSizes.spacingMd),
            Text(
              'Prioridade',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: AppSizes.spacingXs),
            Wrap(
              spacing: AppSizes.spacingSm,
              runSpacing: AppSizes.spacingSm,
              children: const [
                WorkOrderPriorityBadge(priority: WorkOrderPriority.high),
                WorkOrderPriorityBadge(priority: WorkOrderPriority.medium),
                WorkOrderPriorityBadge(priority: WorkOrderPriority.low),
              ],
            ),
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Estados reutilizáveis',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            Wrap(
              spacing: AppSizes.spacingSm,
              runSpacing: AppSizes.spacingSm,
              children: [
                AppOutlineButton(
                  label: 'Loading',
                  onPressed: () =>
                      setState(() => _previewState = _PreviewState.loading),
                ),
                AppOutlineButton(
                  label: 'Vazio',
                  onPressed: () =>
                      setState(() => _previewState = _PreviewState.empty),
                ),
                AppOutlineButton(
                  label: 'Erro',
                  onPressed: () =>
                      setState(() => _previewState = _PreviewState.error),
                ),
                AppOutlineButton(
                  label: 'Conteúdo',
                  onPressed: () =>
                      setState(() => _previewState = _PreviewState.content),
                ),
              ],
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppCard(
              child: switch (_previewState) {
                _PreviewState.loading => const AppLoadingState(itemCount: 2),
                _PreviewState.empty => const AppEmptyState(
                    title: 'Nenhuma inspeção encontrada',
                    message: 'As inspeções salvas aparecerão aqui.',
                  ),
                _PreviewState.error => AppErrorState(
                    message: 'Não foi possível carregar as ordens de serviço.',
                    onRetry: () =>
                        setState(() => _previewState = _PreviewState.content),
                  ),
                _PreviewState.content => Text(
                    'Conteúdo carregado com sucesso.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              },
            ),
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Snackbar',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            Wrap(
              spacing: AppSizes.spacingSm,
              runSpacing: AppSizes.spacingSm,
              children: [
                AppElevatedButton(
                  label: 'Info',
                  onPressed: () =>
                      AppSnackbar.info(context, 'Sincronização iniciada'),
                ),
                AppElevatedButton(
                  label: 'Sucesso',
                  onPressed: () => AppSnackbar.success(
                    context,
                    'Inspeção enviada com sucesso',
                  ),
                ),
                AppElevatedButton(
                  label: 'Erro',
                  onPressed: () => AppSnackbar.error(
                    context,
                    'Falha ao enviar a inspeção',
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Botões',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppOutlineButton(
              label: 'Outline Button',
              icon: Icons.open_in_new,
              onPressed: () {},
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppElevatedButton(
              label: 'Elevated Button',
              icon: Icons.save_outlined,
              onPressed: () {},
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppInlineButton(
              label: 'Inline Button',
              icon: Icons.arrow_forward,
              onPressed: () {},
            ),
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Formulário',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppTextField(
              controller: _emailController,
              label: 'E-mail',
              errorText: _emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (_) {
                if (_emailError != null) {
                  setState(() => _emailError = null);
                }
              },
            ),
            AppTextField(
              controller: _passwordController,
              label: 'Senha',
              errorText: _passwordError,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onChanged: (_) {
                if (_passwordError != null) {
                  setState(() => _passwordError = null);
                }
              },
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppElevatedButton(
              label: 'Validar campos',
              onPressed: _validateFields,
            ),
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Mapa',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            const AppMap(
              points: [
                AppMapPoint(
                  latitude: -23.55052,
                  longitude: -46.633308,
                  label: 'OS — Rua das Acácias',
                  type: AppMapPointType.workOrder,
                ),
                AppMapPoint(
                  latitude: -23.55120,
                  longitude: -46.63210,
                  label: 'Inspeção registrada',
                  type: AppMapPointType.inspection,
                ),
              ],
            ),
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Foto da inspeção',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppElevatedButton(
              label: _isCapturingPhoto ? 'Abrindo câmera...' : 'Capturar foto',
              icon: Icons.photo_camera_outlined,
              onPressed: _isCapturingPhoto ? null : _capturePhoto,
            ),
            if (_capturedPhotoPath != null) ...[
              SizedBox(height: AppSizes.spacingSm),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                child: Image.file(
                  File(_capturedPhotoPath!),
                  height: AppSizes.mapHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            SizedBox(height: AppSizes.spacingLg),
            Text(
              'Controles',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.spacingSm),
            AppSwitch(
              label: 'Switch',
              value: _switchValue,
              onChanged: (value) => setState(() => _switchValue = value),
            ),
            AppRadio<int>(
              label: 'Radio option 1',
              value: 0,
              groupValue: _radioValue,
              onChanged: (value) => setState(() => _radioValue = value!),
            ),
            AppRadio<int>(
              label: 'Radio option 2',
              value: 1,
              groupValue: _radioValue,
              onChanged: (value) => setState(() => _radioValue = value!),
            ),
            AppCheckbox(
              label: 'Checkbox',
              value: _checkboxValue,
              onChanged: (value) =>
                  setState(() => _checkboxValue = value ?? false),
            ),
          ],
        ),
      ),
    );
  }
}
