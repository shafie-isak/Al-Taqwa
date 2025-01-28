import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
  }


Future<void> schedulePrayerNotifications(Map<String, String> prayerTimes) async {
  _notificationsPlugin.cancelAll();
  prayerTimes.forEach((prayer, time) async {
    final prayerTime = DateFormat.jm().parse(time);
    final now = DateTime.now();
    final notificationTime = DateTime(
      now.year,
      now.month,
      now.day,
      prayerTime.hour,
      prayerTime.minute,
    );

    if (notificationTime.isAfter(now)) {
      await _notificationsPlugin.zonedSchedule(
        prayer.hashCode,
        'Prayer Reminder',
        'It’s time for $prayer prayer.',
        tz.TZDateTime.from(notificationTime, tz.local), // Convert to tz.TZDateTime
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'prayer_channel',
            'Prayer Reminders',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact, // New parameter
      );
    }
  });
}
}