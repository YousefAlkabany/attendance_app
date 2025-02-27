class AttendanceModel {
  String? date;
  String? time;
  String? location;
  String? query;
  String? image;
  int? userId;

  AttendanceModel({
    this.userId,
    this.date,
    this.time,
    this.location,
    this.query,
    this.image,
  });

  factory AttendanceModel.fromJson(json, {image, userId}) {
    return AttendanceModel(
        date: json['date'],
        time: json['time'],
        location: json['location'],
        query: json['query'],
        image: image,
        userId: userId);
  }
}
