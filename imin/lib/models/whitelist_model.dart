class WhitelistModel {
  int whitelistId;
  int homeId;
  String homeNumber;
  String role;
  int roleId;
  String firstname;
  String lastname;
  String licensePlate;
  String qrGenId;
  String idCard;
  String email;
  int logId;
  String datetimeIn;
  String residentStamp;
  String datetimeOut;
  String? adminStamp;
  String listStatus;

  WhitelistModel({
    required this.whitelistId,
    required this.homeId,
    required this.homeNumber,
    required this.role,
    required this.roleId,
    required this.firstname,
    required this.lastname,
    required this.licensePlate,
    required this.qrGenId,
    required this.idCard,
    required this.email,
    required this.logId,
    required this.datetimeIn,
    required this.residentStamp,
    required this.datetimeOut,
    required this.adminStamp,
    required this.listStatus,
  });

  factory WhitelistModel.fromJson(dynamic json) {
    return WhitelistModel(
      whitelistId: json['whitelist_id'],
      homeId: json['home_id'],
      homeNumber: json['home_number'],
      role: json['class'],
      roleId: json['class_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      licensePlate: json['license_plate'],
      qrGenId: json['qr_gen_id'],
      idCard: json['id_card'],
      email: json['email'],
      logId: json['log_id'],
      datetimeIn: json['datetime_in'],
      residentStamp: json['resident_stamp'],
      datetimeOut: json['datetime_out'],
      adminStamp: null,
      listStatus: 'whitelist',
    );
  }
}
