import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/pages/pre_checkin/pre_checkin_controller.dart';
import 'package:fe_lab_clinicas_adm/src/shared/data_item.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PreCheckinPage extends StatefulWidget {
  const PreCheckinPage({super.key});

  @override
  State<PreCheckinPage> createState() => _PreCheckinPageState();
}

class _PreCheckinPageState extends State<PreCheckinPage> with MessageViewMixin {
  final controller = Injector.get<PreCheckinController>();

  @override
  void initState() {
    messageListener(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Com o signals é possível ficar escutando a váriavel através do método watch
    // Dessa forma qualquer alteração da informção ele vai executar o build automaticamente.
    final PatientInformationFormModel(:password, :patient) =
        controller.informationForm.watch(context)!;

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
                    style: LabClinicasTheme.titleSmallStyle,
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
                    child: Text(
                      password,
                      style: LabClinicasTheme.titleSmallBoldStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataItem(
                          label: 'Nome do Paciente',
                          value: patient.name,
                        ),
                        const SizedBox(height: 24),
                        DataItem(
                          label: 'Email',
                          value: patient.email,
                        ),
                        const SizedBox(height: 24),
                        DataItem(
                          label: 'Telefone de contato',
                          value: patient.phoneNumber,
                        ),
                        const SizedBox(height: 24),
                        DataItem(
                          label: 'CPF',
                          value: patient.document,
                        ),
                        const SizedBox(height: 24),
                        DataItem(
                          label: 'CEP',
                          value: patient.address.cep,
                        ),
                        const SizedBox(height: 24),
                        DataItem(
                          label: 'Endereço',
                          value:
                              '${patient.address.streetAddress}, ${patient.address.number} '
                              '${patient.address.addressComplement}, ${patient.address.district}, '
                              '${patient.address.city} - ${patient.address.state}',
                        ),
                        const SizedBox(height: 24),
                        Visibility(
                          visible: patient.guardian.isNotEmpty,
                          child: Column(
                            children: [
                              DataItem(
                                label: 'Responsável',
                                value: patient.guardian,
                              ),
                              const SizedBox(height: 24),
                              DataItem(
                                label: 'Documento de identificação',
                                value: patient.guardianIdentificationNumber,
                              ),
                            ],
                          ),
                        )
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
                          onPressed: () {
                            controller.next();
                          },
                          child: const Text('CHAMAR OUTRA SENHA'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(48),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              '/checkin',
                              arguments: controller.informationForm,
                            );
                          },
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
