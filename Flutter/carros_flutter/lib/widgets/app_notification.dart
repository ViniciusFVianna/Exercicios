import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotifications extends StatefulWidget {
  final String title;
  final String body;

  AppNotifications({this.title, this.body});

  @override
  _AppNotificationsState createState() => _AppNotificationsState();
}

class _AppNotificationsState extends State<AppNotifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return showNotification();
  }

  showNotification() async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, widget.title, widget.body, platform,
        );
  }
}
