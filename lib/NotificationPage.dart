import 'package:flutter/material.dart';
import 'Supplementary/ThemeColor.dart';

ThemeColor themeColor = ThemeColor();

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(title: Text('내 소식')),
      body: Center(child: Text('내 소식 페이지')),
    );
  }
}
