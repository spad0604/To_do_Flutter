import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init(){
    _notification.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings()
    ));
    tz.initializeTimeZones();
  }

  static scheduledNotification(String title, String body, DateTime scheduledDateTime) async {
    var androidDetails = const AndroidNotificationDetails(
      'important_notifications', 
      'My Channel',
      importance: Importance.max,
      priority: Priority.high
      );

    var iosDetails = DarwinNotificationDetails();

    var notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    final scheduledTZDateTime = tz.TZDateTime.from(scheduledDateTime, tz.local);
    
    await _notification.zonedSchedule(
      0, 
      title,
      body, 
      scheduledTZDateTime, 
      notificationDetails, 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
      );
  }
}
