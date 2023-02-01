import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('launcher_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future showNotification(int id, String title, String body, DateTime date,
      int hour, int minute) async {
    DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
      0,
      0,
      0,
    );
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(id.toString(), 'Go To Bed',
            importance: Importance.max,
            priority: Priority.max,
            icon: 'launcher_icon'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
