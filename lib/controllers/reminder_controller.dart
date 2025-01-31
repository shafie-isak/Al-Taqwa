import 'package:al_taqwa/controllers/UsersController.dart';
import 'package:al_taqwa/services/notification_service.dartnotification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReminderController extends GetxController {
  var isLoading = true.obs;
  var alarms = <Map<String, dynamic>>[].obs;

  final UsersController _usersController = Get.find<UsersController>();

  @override
  void onInit() {
    super.onInit();
    fetchAlarms();
  }

  Future<void> fetchAlarms() async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/getreminders";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_usersController.token.value}',
        },
      );

      if (response.statusCode == 200) {
        alarms.value =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
        _scheduleExistingAlarms();
      } else {
        print("Failed to fetch alarms: ${response.body}");
      }
    } catch (e) {
      print("Error fetching alarms: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendReminderData(String title, TimeOfDay time) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/add";

    DateTime scheduledTime = _convertTimeOfDayToDateTime(time);
    Map<String, dynamic> data = {
      'title': title,
      'time': scheduledTime.toIso8601String(),
      'isActive': true
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_usersController.token.value}',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Reminder successfully created!😀',
            snackPosition: SnackPosition.TOP);
        fetchAlarms();
        await NotificationService.scheduleNotifications(
            title, "Reminder alert", scheduledTime);
      } else {
        print("Failed to create reminder: ${response.body}");
      }
    } catch (e) {
      print("Error sending data: $e");
    }
  }

  Future<void> updateAlarm(String id, String title, TimeOfDay time) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/update";
    DateTime scheduledTime = _convertTimeOfDayToDateTime(time);
    Map<String, dynamic> data = {
      'title': title,
      'time': scheduledTime.toIso8601String(),
    };

    try {
      final response = await http.put(
        Uri.parse("$apiUrl/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_usersController.token.value}',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Reminder updated successfully!',
            snackPosition: SnackPosition.TOP);
        fetchAlarms();
        await NotificationService.scheduleNotifications(
            title, "Reminder alert", scheduledTime);
      } else {
        print("Failed to update reminder: ${response.body}");
      }
    } catch (e) {
      print("Error updating reminder: $e");
    }
  }

  Future<void> deleteAlarm(String id) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/delete";

    try {
      final response = await http.delete(
        Uri.parse("$apiUrl/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_usersController.token.value}',
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Reminder deleted successfully!',
            snackPosition: SnackPosition.TOP);
        fetchAlarms();
      } else {
        print("Failed to delete reminder: ${response.body}");
      }
    } catch (e) {
      print("Error deleting reminder: $e");
    }
  }

  Future<void> toggleAlarm(String id, bool isActive) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/toggle-alarm";
    Map<String, dynamic> data = {'isActive': isActive};

    try {
      final response = await http.put(
        Uri.parse("$apiUrl/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_usersController.token.value}',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Alarm status updated!',
            snackPosition: SnackPosition.TOP);
        fetchAlarms();
      } else {
        print("Failed to toggle alarm: ${response.body}");
      }
    } catch (e) {
      print("Error toggling alarm: $e");
    }
  }

  void _scheduleExistingAlarms() {
    for (var alarm in alarms) {
      if (alarm['isActive']) {
        DateTime scheduledTime = DateTime.parse(alarm['time']);
        NotificationService.scheduleNotifications(
            alarm['title'], "Reminder Alert", scheduledTime);
      }
    }
  }

  DateTime _convertTimeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }


  Future<void> toggleToDoStatus(String id, bool currentStatus) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/toggle-todo";

    Map<String, dynamic> data = {
      'isToDo': !currentStatus,
    };

    try {
      final response = await http.put(
        Uri.parse("$apiUrl/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${_usersController.token.value}', 
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'To-do status updated successfully!😀',
            snackPosition: SnackPosition.TOP);
        fetchAlarms();
      } else {
        Get.snackbar('Error', 'Failed to update to-do status: ${response.body}',
            snackPosition: SnackPosition.TOP);
        print("Failed to update to-do status: ${response.body}");
      }
    } catch (e) {
      print("Error updating to-do status: $e");
    }
  }

}
