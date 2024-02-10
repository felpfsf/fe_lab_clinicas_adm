import 'package:fe_lab_clinicas_adm/src/pages/end_check_in/end_check_in_controller.dart';
import 'package:fe_lab_clinicas_adm/src/pages/end_check_in/end_check_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class EndCheckInRouter extends FlutterGetItPageRouter {
  const EndCheckInRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
            (i) => EndCheckInController(callNextPatientService: i())),
      ];

  @override
  String get routeName => '/end-checkin';

  @override
  WidgetBuilder get view => (_) => const EndCheckInPage();
}
