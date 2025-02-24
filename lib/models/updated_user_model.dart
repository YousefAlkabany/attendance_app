import 'package:cattendanceapp/models/user_model.dart';

class UpdatedUserModel extends UserModel {
  String message;
  String token;
  int id;
  String name;
  String email;
  String image;
  int role;
  String? password;

  UpdatedUserModel(
      {required this.message,
      required this.token,
      required this.id,
      required this.name,
      required this.email,
      required this.image,
      required this.role,
      this.password})
      : super(
            message: message,
            token: token,
            id: id,
            name: name,
            email: email,
            image: image,
            role: role);

  factory UpdatedUserModel.fromJson(json, password, token) {
    return UpdatedUserModel(
        message: json['message'],
        token: token,
        id: json['data']['id'],
        name: json['data']['name'],
        email: json['data']['email'],
        image: json['data']['image'],
        role: json['data']['role'],
        password: password);
  }
}
