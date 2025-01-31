import 'package:al_taqwa/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  static Future<void> onDidReceiveBackgroundNotification(NotificationResponse notificationResponse) async {

  }

  static Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();    

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, 
      iOS: iOSInitializationSettings
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, 
      onDidReceiveNotificationResponse: onDidReceiveBackgroundNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotification,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }


  static Future<void> showInstantNotificaion(String title, String body) async{
    const NotificationDetails platformChannelSpecifics =  NotificationDetails(
      android: AndroidNotificationDetails("channel_Id"," channel_Name", importance: Importance.high, priority: Priority.high),
      iOS: DarwinNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }


  static Future<void> scheduleNotifications(String title, String body, DateTime scheduledTime) async {
  try {
    print("Scheduling notification for: $scheduledTime");
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    Get.snackbar('succes', 'Notification scheduled successfully!',
            snackPosition: SnackPosition.TOP);

    print("Notification scheduled successfully.");
  } catch (e) {
    Get.snackbar('succes', 'Error scheduling notification: $e',
            snackPosition: SnackPosition.TOP);
    print("Error scheduling notification: $e");
  }
}


}