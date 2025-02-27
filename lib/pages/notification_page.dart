import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/widgets/custom_pages_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, this.userModel});
  final UserModel? userModel;

  static String id = 'notification-page';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  
  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: customPagesAppBar(widget.userModel!, context, 'Notifications'),
    );
  }
}
