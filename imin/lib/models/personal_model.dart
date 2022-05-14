
class PersonalModel {
  final String firstname;
  final String lastname;
  final String idCard;

  PersonalModel({
    required this.firstname,
    required this.lastname,
    required this.idCard,
  });

  factory PersonalModel.fromJson(dynamic json) {
    return PersonalModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      idCard: json['idCard'],
    );
  }
}
