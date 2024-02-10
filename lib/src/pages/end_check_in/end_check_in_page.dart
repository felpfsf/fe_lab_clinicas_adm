import 'package:fe_lab_clinicas_adm/src/pages/end_check_in/end_check_in_controller.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EndCheckInPage extends StatefulWidget {
  const EndCheckInPage({super.key});

  @override
  State<EndCheckInPage> createState() => _EndCheckInPageState();
}

class _EndCheckInPageState extends State<EndCheckInPage> with MessageViewMixin {
  final controller = Injector.get<EndCheckInController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.informationForm() != null) {
        Navigator.of(context).pushReplacementNamed(
          '/pre-checkin',
          arguments: controller.informationForm(),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              width: sizeOf.width * .4,
              margin: const EdgeInsets.only(top: 56),
              padding:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
              decoration: BoxDecoration(
                color: LabClinicasTheme.primaryElement,
                border: Border.all(color: LabClinicasTheme.primaryLabel),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/check_icon.png'),
                  const SizedBox(height: 40),
                  const Text(
                    'Atendimento finalizado com sucesso',
                    style: LabClinicasTheme.titleSmallStyle,
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.callNextPatient();
                      },
                      child: const Text('CHAMAR OUTRA SENHA'),
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
