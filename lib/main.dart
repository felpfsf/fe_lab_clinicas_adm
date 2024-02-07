import 'dart:async';
import 'dart:developer';

import 'package:fe_lab_clinicas_adm/src/binding/lab_clinicas_application_binding.dart';
import 'package:fe_lab_clinicas_adm/src/pages/login/login_router.dart';
import 'package:fe_lab_clinicas_adm/src/pages/splash/splash_page.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const LabClinicasAdmApp());
  }, (error, stack) {
    log("Erro não tratado", error: error, stackTrace: stack);
    throw error;
  });
}

class LabClinicasAdmApp extends StatelessWidget {
  const LabClinicasAdmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: 'Lab Clinicas Atendimento',
      binding: LabClinicasApplicationBinding(),
      pagesBuilder: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/'),
        FlutterGetItPageBuilder(page: (_) => const HomePage(), path: '/home'),
      ],
      pages: const [
        LoginRouter(),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
