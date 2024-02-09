import 'package:fe_lab_clinicas_adm/src/shared/data_item.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class PreCheckinPage extends StatelessWidget {
  const PreCheckinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: sizeOf.height),
          decoration: const BoxDecoration(
            color: LabClinicasTheme.secondaryBackground,
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              constraints: BoxConstraints(maxWidth: sizeOf.width * .4),
              decoration: BoxDecoration(
                color: LabClinicasTheme.primaryElement,
                border: Border.all(color: LabClinicasTheme.primaryLabel),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/patient_avatar.png'),
                  const SizedBox(height: 16),
                  const Text(
                    'A senha chamada foi',
                    style: LabClinicasTheme.titleSmallBoldStyle,
                  ),
                  const SizedBox(height: 16),
                  Container(
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
                    child: const Text(
                      'SENHA',
                      style: LabClinicasTheme.titleSmallBoldStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 48),
                  const SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataItem(label: 'Nome do Paciente', value: 'Fulano'),
                        SizedBox(height: 24),
                        DataItem(label: 'Email', value: 'Fulano'),
                        SizedBox(height: 24),
                        DataItem(label: 'Telefone de contato', value: 'Fulano'),
                        SizedBox(height: 24),
                        DataItem(label: 'CPF', value: 'Fulano'),
                        SizedBox(height: 24),
                        DataItem(label: 'CEP', value: 'Fulano'),
                        SizedBox(height: 24),
                        DataItem(label: 'Endereço', value: 'Fulano'),
                        SizedBox(height: 24),
                        Visibility(
                          visible: true,
                          child:
                              DataItem(label: 'Responsável', value: 'Fulano'),
                        ),
                        SizedBox(height: 24),
                        Visibility(
                          visible: true,
                          child: DataItem(
                              label: 'Documento de identificação',
                              value: 'Fulano'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size.fromHeight(48),
                          ),
                          onPressed: () {},
                          child: const Text('CHAMAR OUTRA SENHA'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(48),
                          ),
                          onPressed: () {},
                          child: const Text('ATENDER '),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
