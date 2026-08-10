import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/components/elevated_button.dart';
import 'package:inspetorsys/components/text_field.dart';
import 'package:inspetorsys/constants/app_assets.dart';
import 'package:inspetorsys/core/feedback/app_snackbar.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/login_cubit.dart';
import 'package:inspetorsys/features/auth/presentation/cubit/login_state.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<LoginCubit>().submit(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) async {
        if (state.status == LoginStatus.success && state.authToken != null) {
          await context.read<AuthSessionCubit>().signIn(state.authToken!);
          return;
        }

        if (state.status == LoginStatus.failure &&
            state.errorMessage != null &&
            state.emailError == null &&
            state.passwordError == null) {
          AppSnackbar.error(
            context,
            localizeFailureMessage(context.l10n, state.errorMessage!),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.cardPadding),
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                final l10n = context.l10n;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: AppSizes.spacingLg),
                    Center(
                      child: Image.asset(
                        AppAssets.logoInspetorsys,
                        width: 55.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      AppBranding.appName,
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSizes.spacingXs),
                    Text(
                      l10n.appSlogan,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.75),
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSizes.spacing3xl),
                    AppTextField(
                      controller: _emailController,
                      label: l10n.loginEmailLabel,
                      compact: true,
                      errorText: state.emailError,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      enabled: !state.isSubmitting,
                      onChanged: (_) => context.read<LoginCubit>().onEmailChanged(),
                      onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                    ),
                    AppTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      label: l10n.loginPasswordLabel,
                      compact: true,
                      errorText: state.passwordError,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      enabled: !state.isSubmitting,
                      suffixIcon: _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      onSuffixIconPressed: state.isSubmitting
                          ? null
                          : () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                      onChanged: (_) =>
                          context.read<LoginCubit>().onPasswordChanged(),
                      onSubmitted: (_) => _submit(),
                    ),
                    AppElevatedButton(
                      label: state.isSubmitting ? l10n.loginSubmitting : l10n.loginSubmit,
                      textColor: AppColors.primaryTextColorLight,
                      labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      onPressed: state.isSubmitting ? null : _submit,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
