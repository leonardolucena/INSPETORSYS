import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:inspetorsys/theme/app_text_theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.focusNode,
    this.autofillHints,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.compact = false,
    this.helperText,
    this.hintText,
    this.minLines,
    this.reserveErrorSpace = true,
  });

  final TextEditingController? controller;
  final String label;
  final String? errorText;
  final String? helperText;
  final String? hintText;
  final int? minLines;
  final bool reserveErrorSpace;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool compact;

  bool get _hasError => errorText != null && errorText!.isNotEmpty;
  bool get _showLabel => label.isNotEmpty;
  bool get _isMultiline => maxLines > 1;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor =
        isDark ? AppColors.backgroundCardDark : AppColors.backgroundCardLight;
    final enabledBorderColor = isDark
        ? AppColors.borderCardDark
        : AppColors.primaryTextColorLight.withValues(alpha: 0.3);
    final labelColor = isDark
        ? AppColors.primaryTextColorDark
        : AppColors.primaryTextColorLight;
    final borderColor = _hasError ? AppColors.borderError : enabledBorderColor;
    final focusedBorderColor =
        _hasError ? AppColors.borderError : colorScheme.primary;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      borderSide: BorderSide(color: borderColor),
    );

    final suffix = suffixIcon == null
        ? null
        : GestureDetector(
            onTap: enabled ? onSuffixIconPressed : null,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.spacingSm),
              child: Icon(
                suffixIcon,
                size: AppSizes.inputSuffixIconSize,
                color: enabled
                    ? colorScheme.onSurface.withValues(alpha: 0.6)
                    : colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          minLines: _isMultiline ? minLines : null,
          maxLines: maxLines,
          autofillHints: autofillHints,
          style: Theme.of(context).textTheme.bodyLarge,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            labelText: _showLabel ? label : null,
            hintText: hintText,
            floatingLabelBehavior: _showLabel
                ? (_isMultiline
                    ? FloatingLabelBehavior.always
                    : FloatingLabelBehavior.auto)
                : FloatingLabelBehavior.never,
            alignLabelWithHint: _isMultiline,
            filled: true,
            fillColor: enabled ? fillColor : fillColor.withValues(alpha: 0.5),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.inputPaddingH,
              vertical: AppSizes.inputPaddingV,
            ),
            labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: labelColor,
                ),
            floatingLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _hasError ? AppColors.borderError : labelColor,
                ),
            enabledBorder: border,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              borderSide: BorderSide(color: focusedBorderColor, width: 2),
            ),
            disabledBorder: border,
            border: border,
            suffixIcon: suffix,
          ),
        ),
        if (helperText != null && !_hasError) ...[
          SizedBox(height: AppSizes.spacingXs / 2),
          Text(
            helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
        ],
        if (_hasError || reserveErrorSpace) ...[
          SizedBox(height: compact ? 0 : AppSizes.spacingXs),
          SizedBox(
            height: _hasError || reserveErrorSpace
                ? (compact
                    ? AppSizes.errorAreaHeightCompact
                    : AppSizes.errorAreaHeight)
                : 0,
            width: double.infinity,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                errorText ?? '',
                style: AppTextTheme.error,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
