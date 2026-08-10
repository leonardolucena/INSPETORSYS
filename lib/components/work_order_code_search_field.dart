import 'package:flutter/material.dart';
import 'package:inspetorsys/components/text_field.dart';
import 'package:inspetorsys/core/locale/l10n_extensions.dart';

class WorkOrderCodeSearchField extends StatelessWidget {
  const WorkOrderCodeSearchField({
    super.key,
    this.controller,
    this.onChanged,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: '',
      hintText: context.l10n.searchByWorkOrderCodePlaceholder,
      suffixIcon: Icons.search,
      compact: true,
      reserveErrorSpace: false,
      maintainBorderOnFocus: true,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
    );
  }
}
