import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/pages/profile/about_us_page.dart';
import 'package:cattendanceapp/pages/profile/change_password_page.dart';
import 'package:cattendanceapp/pages/profile/edit_profile_page.dart';
import 'package:cattendanceapp/pages/profile/privacy_policy_page.dart';
import 'package:cattendanceapp/pages/profile/terms_and_conditions_page.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:cattendanceapp/utils/attendance_icons.dart';
import 'package:cattendanceapp/widgets/custom_inkwell_button.dart';
import 'package:cattendanceapp/widgets/inkwell_row_item.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = 'profile-page';
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)?.settings.arguments as UserModel;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 36,
            vertical: height / 36,
          ),
          child: Column(
            children: [
              SizedBox(
                height: height / 16,
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 65,
                      child: CircleAvatar(
                        backgroundColor: AttendanceColor.transparent,
                        radius: 60,
                        backgroundImage:
                            NetworkImage('$kImageNetworkUrl${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 46,
              ),
              Text(userModel.name,
                  style: lsemiBold.copyWith(
                    fontSize: 20,
                  )),
              SizedBox(
                height: height / 120,
              ),
              Text(userModel.email,
                  style: lregular.copyWith(
                    fontSize: 14,
                  )),
              SizedBox(
                height: height / 36,
              ),
              CustomInkwellButton(
                text: 'Edit Profile',
                onTap: () {
                  Navigator.pushNamed(context, EditProfilePage.id , arguments: userModel);
                },
              ),
              SizedBox(
                height: height / 96,
              ),
              const Divider(color: AttendanceColor.lightgrey),
              SizedBox(
                height: height / 96,
              ),
              InkwellRowItem(
                onTap: () {
                  Navigator.pushNamed(context, TermsAndConditionsPage.id);
                },
                text: 'Terms Conditions',
                image: AttendancePngimage.terms,
              ),
              const Divider(color: AttendanceColor.lightgrey),
              SizedBox(
                height: height / 96,
              ),
              InkwellRowItem(
                onTap: () {
                  Navigator.pushNamed(context, PrivacyPolicyPage.id);
                },
                text: 'Privacy Policy',
                image: AttendancePngimage.privacy,
              ),
              const Divider(color: AttendanceColor.lightgrey),
              SizedBox(
                height: height / 96,
              ),
              InkwellRowItem(
                onTap: () {
                  Navigator.pushNamed(context, AboutUsPage.id);
                },
                text: 'About Us',
                image: AttendancePngimage.coffee,
              ),
              const Divider(color: AttendanceColor.lightgrey),
              SizedBox(
                height: height / 96,
              ),
              InkwellRowItem(
                onTap: () {
                  Navigator.pushNamed(context, ChangePasswordPage.id);
                },
                text: 'Change Password',
                image: AttendancePngimage.lock,
              ),
              const Divider(color: AttendanceColor.lightgrey),
              SizedBox(
                height: height / 96,
              ),
              InkwellRowItem(
                onTap: () {
                  Navigator.pushNamed(context, ChangePasswordPage.id);
                },
                text: 'Delete Account',
                image: AttendancePngimage.profile,
                color: const Color.fromARGB(255, 255, 186, 181),
              ),
              const Divider(color: AttendanceColor.lightgrey),
              SizedBox(
                height: height / 96,
              ),
              InkwellRowItem(
                onTap: () {
                  Navigator.pushNamed(context, ChangePasswordPage.id);
                },
                text: 'Log Out',
                image: AttendancePngimage.logout,
                color: const Color.fromARGB(255, 255, 186, 181),
              ),
              const Divider(color: AttendanceColor.lightgrey),
            ],
          ),
        ),
      ),
    );
  }
}
