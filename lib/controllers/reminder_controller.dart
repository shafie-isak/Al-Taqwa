import 'package:al_taqwa/controllers/UsersController.dart';
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
                alarms.value = List<Map<String, dynamic>>.from(jsonDecode(response.body));
            } else {
                print("Failed to fetch alarms: ${response.body}");
            }
        } catch (e) {
            print("Error fetching alarms: $e");
        } finally {
            isLoading.value = false;
        }
    }

  Future<void> sendReminderData(String title, List<bool> days, TimeOfDay time) async {
        const String apiUrl = "http://10.0.2.2:5000/api/reminders/add";

        List<String> selectedDays = [];
        List<String> dayNames = ['Sat', 'Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri'];

        for (int i = 0; i < days.length; i++) {
            if (days[i]) {
                selectedDays.add(dayNames[i]);
            }
        }

        String formattedTime =
            "${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')} ${time.period == DayPeriod.am ? "AM" : "PM"}";

        Map<String, dynamic> data = {
            'title': title,
            'recurringDays': selectedDays,
            'time': formattedTime,
        };

        try {
            final response = await http.post(
                Uri.parse(apiUrl),
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ${_usersController.token.value}', // Add token to headers
                },
                body: jsonEncode(data),
            );

            if (response.statusCode == 201) {
                Get.snackbar('Success', 'Reminder successfully created!😀',
                      snackPosition: SnackPosition.TOP);
                fetchAlarms();
            } else {
              Get.snackbar('Erorr', 'Failed to create reminder: ${response.body}',
                      snackPosition: SnackPosition.TOP);
                print("Failed to create reminder: ${response.body}");
            }
        } catch (e) {
            print("Error sending data: $e");
        }
    }

Future<void> updateAlarm(String id, String title, List<bool> days, TimeOfDay time) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/update";

    List<String> selectedDays = [];
    List<String> dayNames = ['Sat', 'Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri'];

    for (int i = 0; i < days.length; i++) {
        if (days[i]) {
            selectedDays.add(dayNames[i]);
        }
    }

    String formattedTime =
        "${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')} ${time.period == DayPeriod.am ? "AM" : "PM"}";

    Map<String, dynamic> data = {
        'title': title,
        'recurringDays': selectedDays,
        'time': formattedTime,
    };

    try {
        final response = await http.put(
            Uri.parse("$apiUrl/$id"),
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${_usersController.token.value}', // Include token
            },
            body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
            Get.snackbar('Success', 'Reminder updated successfully!😀',
                  snackPosition: SnackPosition.TOP);
            fetchAlarms();
        } else {
            Get.snackbar('Error', 'Failed to update reminder: ${response.body}',
                  snackPosition: SnackPosition.TOP);
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
                'Authorization': 'Bearer ${_usersController.token.value}', // Include token
            },
        );

        if (response.statusCode == 200) {
            Get.snackbar('Success', 'Reminder deleted successfully!😀',
                  snackPosition: SnackPosition.TOP);
            fetchAlarms();
        } else {
            Get.snackbar('Error', 'Failed to delete reminder: ${response.body}',
                  snackPosition: SnackPosition.TOP);
            print("Failed to delete reminder: ${response.body}");
        }
    } catch (e) {
        print("Error deleting reminder: $e");
    }
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
                'Authorization': 'Bearer ${_usersController.token.value}', // Include token
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