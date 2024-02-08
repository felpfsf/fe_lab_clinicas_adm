import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import './attendant_desk_assignment_repository.dart';

class AttendantDeskAssignmentRepositoryImpl
    implements AttendantDeskAssignmentRepository {
  AttendantDeskAssignmentRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, Unit>> startService(int deskNumber) async {
    final result = await _clearTicketWindowByUser();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right():
        await restClient.auth.post('/attendantDeskAssignment', data: {
          'userid': '#userAuthRef',
          'desk_number': deskNumber,
          'date_created': DateTime.now().toIso8601String(),
          'status': 'Avaliable'
        });
        return Right(unit);
    }
  }

  Future<Either<RepositoryException, Unit>> _clearTicketWindowByUser() async {
    try {
      final booth = await _getTicketWindowByUser();
      if (booth != null) {
        await restClient.auth.delete('/attendantDeskAssignment/${booth.id}');
      }
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao deletar numero do guichê', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  Future<({String id, int deskNumber})?> _getTicketWindowByUser() async {
    final Response(:List data) =
        await restClient.auth.get('/attendantDeskAssignment', queryParameters: {
      // Em um backend real seria mandado para um serviço que de fato pegaria o userId
      'user_id':
          '#userAuthRef' // Tag para o JRS, ele identifica automaticamente, abre o token e passa o id correto
    });

    if (data
        case List(
          isNotEmpty: true,
          first: {'id': String id, 'desk_number': int deskNumber}
        )) {
      return (
        id: id,
        deskNumber: deskNumber,
      );
    }

    return null;
  }

  @override
  Future<Either<RepositoryException, int>> getDeskAssignment() async {
    try {
      final Response(data: List(first: data)) = await restClient.auth
          .get('/attendantDeskAssignment', queryParameters: {
        'user_id': #userAuthRef,
      });

      return Right(data['desk_number']);
    } on DioException catch (e, s) {
      log('Erro ao recuperar guichê', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
