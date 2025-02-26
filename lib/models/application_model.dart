class ApplicationModel {
  int id;
  int userId;
  String title;
  String status;
  String leaveType;
  String contactNumber;
  String startDate;
  String endDate;
  String reason;

  ApplicationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.leaveType,
    required this.contactNumber,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });

  factory ApplicationModel.fromJson(json, int applicationId) {
    return ApplicationModel(
        id: json['data'][applicationId]['id'],
        userId: json['data'][applicationId]['user_id'],
        title: json['data'][applicationId]['title'],
        leaveType: json['data'][applicationId]['leave_type'],
        contactNumber: json['data'][applicationId]['contact_number'],
        startDate: json['data'][applicationId]['start_date'],
        endDate: json['data'][applicationId]['end_date'],
        reason: json['data'][applicationId]['reason'],
        status: json['data'][applicationId]['status']);
  }
}
