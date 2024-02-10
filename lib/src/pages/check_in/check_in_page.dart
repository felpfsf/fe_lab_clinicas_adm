import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/pages/check_in/check_in_controller.dart';
import 'package:fe_lab_clinicas_adm/src/pages/check_in/widgets/checkin_image_link.dart';
import 'package:fe_lab_clinicas_adm/src/shared/data_item.dart';
import 'package:fe_lab_clinicas_adm/src/shared/patient_password_panel.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> with MessageViewMixin {
  final controller = Injector.get<CheckInController>();

  @override
  void initState() {
    messageListener(controller);

    effect(() {
      if (controller.endProcess.value) {
        Navigator.of(context).pushReplacementNamed('/end-checkin');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PatientInformationFormModel(
      :password,
      :patient,
      :healthInsuranceCard,
      :medicalOrder
    ) = controller.informationForm.watch(context)!;
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: sizeOf.height),
          color: LabClinicasTheme.secondaryBackground,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 56),
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
              width: sizeOf.width * .4,
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
                  PatientPasswordPanel(password: password),
                  const SizedBox(height: 48),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: LabClinicasTheme.secondaryBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Cadastro',
                      style: LabClinicasTheme.titleSmallStyle
                          .copyWith(color: LabClinicasTheme.primaryLabel),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Form
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: LabClinicasTheme.secondaryBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Validar Imagens Exames',
                      style: LabClinicasTheme.titleSmallStyle
                          .copyWith(color: LabClinicasTheme.primaryLabel),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Exames
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CheckinImageLink(
                          label: 'Carteirinha', image: healthInsuranceCard),
                      Column(
                        children: [
                          for (final (index, medicalOrder)
                              in medicalOrder.indexed)
                            CheckinImageLink(
                              label: 'Pedido Médico #${index + 1}',
                              image: medicalOrder,
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.endCheckin();
                      },
                      child: const Text('FINALIZAR ATENDIMENTO'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
