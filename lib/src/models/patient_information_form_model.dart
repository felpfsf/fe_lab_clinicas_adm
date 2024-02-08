import 'package:fe_lab_clinicas_adm/src/models/patient_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient_information_form_model.g.dart';

@JsonEnum(valueField: 'id')
enum PatientInformationFormStatus {
  wating('Wating'),
  checkIn('Checked In'),
  beingAttended('Being Attended');

  final String id;
  const PatientInformationFormStatus(this.id);
}

@JsonSerializable()
class PatientInformationFormModel {
  PatientInformationFormModel({
    required this.id,
    required this.patient,
    required this.healthInsuranceCard,
    required this.medialOrder,
    required this.password,
    required this.dateCreated,
    required this.status,
  });

  final String id;
  final PatientModel patient;
  @JsonKey(name: 'health_insurance_card')
  final String healthInsuranceCard;
  @JsonKey(name: 'medial_order')
  final List<String> medialOrder;
  final String password;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  final PatientInformationFormModel status;

  factory PatientInformationFormModel.fromJson(Map<String, dynamic> json) =>
      _$PatientInformationFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInformationFormModelToJson(this);
}