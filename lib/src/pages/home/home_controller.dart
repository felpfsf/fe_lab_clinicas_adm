import 'package:asyncstate/asyncstate.dart' as asyncState;
import 'package:fe_lab_clinicas_adm/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

class HomeController with MessageStateMixin {
  HomeController({
    required AttendantDeskAssignmentRepository
        attendantDeskAssignmentRepository,
  }) : _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository;

  final AttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;

  Future<void> startService(int ticketWindow) async {
    asyncState.AsyncState.show();
    final result =
        await _attendantDeskAssignmentRepository.startService(ticketWindow);

    switch (result) {
      case Left():
        asyncState.AsyncState.hide();
        showError('Erro ao iniciar guichê, contate o suporte');
      case Right(value: _):
      asyncState.AsyncState.hide();
      showInfo('Registrado com sucesso');
    }
  }
}
