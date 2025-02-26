import 'package:cattendanceapp/helpers/functions.dart';
import 'package:cattendanceapp/models/updated_user_model.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/pages/home_page.dart';
import 'package:cattendanceapp/services/user_service.dart';
import 'package:cattendanceapp/widgets/custom_inkwell_button.dart';
import 'package:cattendanceapp/widgets/custom_pages_app_bar.dart';
import 'package:cattendanceapp/widgets/custom_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  static String id = 'changepassword-page';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> formkey = GlobalKey();
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? newPassword;

  @override
  Widget build(BuildContext context) {
    var userModel = ModalRoute.of(context)?.settings.arguments as UserModel;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: customPagesAppBar(userModel, context, 'Change Password'),
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 36, vertical: height / 36),
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Old Password',
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                  if (data != userModel.password) {
                    return 'Wrong password';
                  }
                  return null;
                },
                onChanged: (data) {},
              ),
              SizedBox(
                height: height / 42,
              ),
              CustomTextField(
                labelText: 'New Password',
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                  return null;
                },
                onChanged: (data) {
                  newPassword = data;
                  setState(() {});
                },
              ),
              SizedBox(
                height: height / 42,
              ),
              CustomTextField(
                labelText: 'Confirm Password',
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                  if (data != newPassword) {
                    return 'Password dont match';
                  }
                  return null;
                },
                onChanged: (data) {},
              ),
              const Spacer(),
              CustomInkwellButton(
                text: 'Update',
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    String token = userModel.token;
                    try {
                      Map<String, dynamic> updatedData = {
                        'name': userModel.name,
                        'email': userModel.email,
                        'password': newPassword,
                        '_method': 'PUT',
                      };
                      Response response = await UserService(Dio()).updateUser(
                          updatedData, userModel.token, userModel.id);

                      userModel = UpdatedUserModel.fromJson(
                          response.data, newPassword, token);

                      showSnackBarMessage(context, 'User updated succesfully');

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage(userModel: userModel);
                      }));
                    } catch (e) {
                      showSnackBarMessage(context, e.toString());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
