import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  const DataItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: LabClinicasTheme.smallBody,
        children: [
          TextSpan(text: '$label: '),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: LabClinicasTheme.primaryLabel,
            ),
          ),
        ],
      ),
    );
  }
}
