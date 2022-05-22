class BlacklistModel {
  int blacklistId;
  int homeId;
  String homeNumber;
  String role;
  int roleId;
  String firstname;
  String lastname;
  String licensePlate;
  String idCard;
  int logId;
  String datetimeIn;
  String residentStamp;
  String datetimeOut;
  String listStatus;

  BlacklistModel({
    required this.blacklistId,
    required this.homeId,
    required this.homeNumber,
    required this.role,
    required this.roleId,
    required this.firstname,
    required this.lastname,
    required this.licensePlate,
    required this.idCard,
    required this.logId,
    required this.datetimeIn,
    required this.residentStamp,
    required this.datetimeOut,
    required this.listStatus,
  });

  factory BlacklistModel.fromJson(dynamic json) {
    return BlacklistModel(
      blacklistId: json['blacklist_id'],
      homeId: json['home_id'],
      homeNumber: json['home_number'],
      role: json['class'],
      roleId: json['class_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      licensePlate: json['license_plate'],
      idCard: json['id_card'],
      logId: json['log_id'],
      datetimeIn: json['datetime_in'],
      residentStamp: json['resident_stamp'],
      datetimeOut: json['datetime_out'],
      listStatus: 'blacklist',
    );
  }
}
