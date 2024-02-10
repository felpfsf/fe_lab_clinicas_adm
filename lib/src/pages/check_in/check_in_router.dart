import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/pages/check_in/check_in_controller.dart';
import 'package:fe_lab_clinicas_adm/src/pages/check_in/check_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_getit/flutter_getit.dart';

class CheckInRouter extends FlutterGetItPageRouter {
  const CheckInRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
            (i) => CheckInController(patientInformationFormRepository: i())),
      ];

  @override
  String get routeName => '/checkin';

  @override
  WidgetBuilder get view => (context) {
        final form = ModalRoute.of(context)!.settings.arguments
            as PatientInformationFormModel;
        context.get<CheckInController>().informationForm.value = form;
        return const CheckInPage();
      };
}
