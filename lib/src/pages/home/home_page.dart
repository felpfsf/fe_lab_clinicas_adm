import 'package:fe_lab_clinicas_adm/src/pages/home/home_controller.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {
  final controller = Injector.get<HomeController>();
  final formKey = GlobalKey<FormState>();
  final ticketWindowEC = TextEditingController();

  @override
  void initState() {
    messageListener(controller);
    super.initState();
  }

  @override
  void dispose() {
    ticketWindowEC.dispose();
    super.dispose();
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
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              constraints: BoxConstraints(maxWidth: sizeOf.width * .4),
              decoration: BoxDecoration(
                color: LabClinicasTheme.primaryElement,
                border: Border.all(color: LabClinicasTheme.primaryLabel),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Bem-Vindo!',
                      style: LabClinicasTheme.titleStyle,
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Preencha o número do guichê que você está atendendo',
                      style: LabClinicasTheme.medium16,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: ticketWindowEC,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: Validatorless.multiple([
                        Validatorless.required('Número do guichê obrigatório'),
                        Validatorless.number('Guichê deve ser um número'),
                      ]),
                      decoration: const InputDecoration(
                        label: Text('Número do guichê'),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;

                          if (valid) {
                            controller
                                .startService(int.parse(ticketWindowEC.text));
                          }
                        },
                        child: const Text('CHAMAR PRÓXIMO PACIENTE'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
