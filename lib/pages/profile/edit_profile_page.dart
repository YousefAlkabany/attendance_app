import 'dart:developer';
import 'dart:io';

import 'package:cattendanceapp/helpers/functions.dart';
import 'package:cattendanceapp/models/updated_user_model.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/pages/home_page.dart';
import 'package:cattendanceapp/services/user_service.dart';
import 'package:cattendanceapp/widgets/custom_avatar_with_stacked_button.dart';
import 'package:cattendanceapp/widgets/custom_inkwell_button.dart';
import 'package:cattendanceapp/widgets/custom_pages_app_bar.dart';
import 'package:cattendanceapp/widgets/custom_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  static String id = 'editprofile-page';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> formkey = GlobalKey();
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  String? name;
  File? selectedImage;
  TextEditingController textController = TextEditingController();

  //to pick image from gallery

  Future pickImageGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var userModel = ModalRoute.of(context)?.settings.arguments as UserModel;

    if (name == null) {
      textController.text = userModel.name;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customPagesAppBar(userModel, context, 'Edit Profile'),
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 36, vertical: height / 36),
          child: Column(
            children: [
              Center(
                child: CustomAvatarWithStackedButton(
                  selectedImage: selectedImage,
                  userModel: userModel,
                  onTap: () {
                    pickImageGallery();
                  },
                ),
              ),
              SizedBox(
                height: height / 24,
              ),
              CustomTextField(
                textController: textController,
                labelText: 'Name',
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onChanged: (data) {
                  name = data;
                },
              ),
              const Spacer(),
              CustomInkwellButton(
                text: 'Update',
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    String password = userModel.password!;
                    String token = userModel.token;
                    try {
                      Map<String, dynamic> updatedData = {
                        'name': name ?? userModel.name,
                        'email': userModel.email,
                        'password': password,
                        '_method': 'PUT',
                        if (selectedImage != null)
                          'image': await MultipartFile.fromFile(
                              selectedImage!.path,
                              filename: p.basename(selectedImage!.path)),
                      };

                      Response response = await UserService(Dio()).updateUser(
                          updatedData, userModel.token, userModel.id);

                      userModel = UpdatedUserModel.fromJson(
                          response.data, password, token);

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
