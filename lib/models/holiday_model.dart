class HolidayModel {
  final String date;
  final String localName;
  final String countryCode;

  const HolidayModel({
    required this.date,
    required this.localName,
    required this.countryCode,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      date: json['date'],
      localName: json['localName'],
      countryCode: json['countryCode'],
    );
  }
}
