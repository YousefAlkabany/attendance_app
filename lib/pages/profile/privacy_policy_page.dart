import 'package:cattendanceapp/helpers/functions.dart';
import 'package:cattendanceapp/models/page_model.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/services/page_services.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:cattendanceapp/widgets/custom_pages_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  PrivacyPolicyPage({super.key, this.userModel});
  UserModel? userModel;
  static String id = 'privacypolicy-page';

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  PageModel? pageModel;

  Future<void> getPages(String token) async {
    try {
      pageModel = await PageServices(Dio()).getPages(token, 1);

      setState(() {});
    } catch (e) {
      showSnackBarMessage(context, e.toString());
    }
  }

  @override
  void initState() {
    getPages(widget.userModel!.token);
    super.initState();
  }

  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar:
          customPagesAppBar(widget.userModel!, context, 'Privacy and Policy'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 36, vertical: height / 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pageModel?.lastUpdatedAtStaticText ?? '',
                style: lmedium.copyWith(
                    fontSize: 13, color: AttendanceColor.textgray),
              ),
              SizedBox(
                height: height / 66,
              ),
              Text(
                pageModel?.noticeText ?? '',
                style: lregular.copyWith(fontSize: 15),
              ),
              SizedBox(
                height: height / 66,
              ),
              Text(
                pageModel?.headText ?? '',
                style: lregular.copyWith(
                    fontSize: 20, color: AttendanceColor.primary),
              ),
              SizedBox(
                height: height / 66,
              ),
              Text(
                pageModel?.bodyText ?? '',
                style: lregular.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
