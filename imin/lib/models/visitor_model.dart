class VisitorModel {
  int visitorId;
  int homeId;
  String homeNumber;
  String role;
  int roleId;
  String firstname;
  String lastname;
  String licensePlate;
  String idCard;
  String inviteDate;
  String qrGenId;
  int logId;
  String datetimeIn;
  String residentStamp;
  String datetimeOut;
  String? adminStamp;

  VisitorModel({
    required this.visitorId,
    required this.homeId,
    required this.homeNumber,
    required this.role,
    required this.roleId,
    required this.firstname,
    required this.lastname,
    required this.licensePlate,
    required this.idCard,
    required this.inviteDate,
    required this.qrGenId,
    required this.logId,
    required this.datetimeIn,
    required this.residentStamp,
    required this.datetimeOut,
    this.adminStamp,
  });

  factory VisitorModel.fromJson(dynamic json) {
    return VisitorModel(
      visitorId: json['visitor_id'],
      homeId: json['home_id'],
      homeNumber: json['home_number'],
      role: json['class'],
      roleId: json['class_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      licensePlate: json['license_plate'],
      idCard: json['id_card'],
      inviteDate: json['invite_date'],
      qrGenId: json['qr_gen_id'],
      logId: json['log_id'],
      datetimeIn: json['datetime_in'],
      residentStamp: json['resident_stamp'],
      datetimeOut: json['datetime_out'],
      adminStamp: null,
    );
  }
}
