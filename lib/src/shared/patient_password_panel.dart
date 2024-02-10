import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class PatientPasswordPanel extends StatelessWidget {
  const PatientPasswordPanel({
    super.key,
    required this.password,
  });

  final String password;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 248,
        minHeight: 48,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: LabClinicasTheme.primaryLabel,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        password.toUpperCase(),
        style: LabClinicasTheme.titleSmallBoldStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
