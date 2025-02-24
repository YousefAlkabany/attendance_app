import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/helpers/functions.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/pages/home_page.dart';
import 'package:cattendanceapp/services/login_service.dart';
import 'package:cattendanceapp/widgets/custom_buton.dart';
import 'package:cattendanceapp/widgets/custom_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String id = 'login-page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
      ),
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 6,
                ),
                Image.asset(
                  kLogo,
                  width: 150,
                  height: 150,
                ),
                const Spacer(
                  flex: 4,
                ),
                const Row(
                  children: [
                    Text(
                      'Welcome Again 😊',
                      style:
                          TextStyle(fontSize: 20, fontFamily: 'LexendSemiBold'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'field is required';
                    }
                  },
                  labelText: 'Email',
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'field is required';
                    }
                  },
                  onChanged: (data) {
                    password = data;
                  },
                  labelText: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButon(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      Response? response =
                          await LoginService(Dio()).login(email!, password!);
                      if (response != null &&
                          response.data['message'] == 'success') {
                        UserModel userModel =
                            UserModel.fromJson(response.data, password);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomePage(
                            userModel: userModel,
                          );
                        }));
                      } else {
                        showSnackBarMessage(
                            context, "Wrong Email or Password 😔");
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: 'Login',
                ),
                const Spacer(
                  flex: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
