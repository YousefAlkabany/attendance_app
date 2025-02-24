class AttendanceModel {
  String? date;
  String? time;
  String? location;
  String? query;

  AttendanceModel({
    this.date,
    this.time,
    this.location,
    this.query,
  });

  factory AttendanceModel.fromJson(json) {
    return AttendanceModel(
      date: json['date'],
      time: json['time'],
      location: json['location'],
      query: json['query'],
    );
  }
}
