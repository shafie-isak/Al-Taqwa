import 'package:al_taqwa/controllers/reminder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:al_taqwa/Screens/reminders/set_reminder_bottom_sheet.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

class Alarms extends StatefulWidget {
  const Alarms({super.key});

  @override
  State<Alarms> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> with SingleTickerProviderStateMixin {
  bool _loading = true;
  List<Map<String, dynamic>> alarms = [];

  @override
  void initState() {
    super.initState();
    _fetchAlarms();
  }

  /// Fetch alarms from the backend
  Future<void> _fetchAlarms() async {
    const String apiUrl =
        "http://10.0.2.2:5000/api/reminders/getreminders"; // Adjust for backend URL

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          alarms = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          _loading = false;
        });
      } else {
        print("Failed to fetch alarms: ${response.body}");
        setState(() => _loading = false);
      }
    } catch (e) {
      print("Error fetching alarms: $e");
      setState(() => _loading = false);
    }
  }

  // Convert String time to timeOfDay type
  /// Convert "6:00 AM" string to TimeOfDay
  ///
  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(" ");
    final timeParts = parts[0].split(":").map(int.parse).toList();
    final isPM = parts[1] == "PM";

    return TimeOfDay(
      hour: isPM && timeParts[0] != 12 ? timeParts[0] + 12 : timeParts[0] % 12,
      minute: timeParts[1],
    );
  }

  /// Show the bottom sheet for adding a reminder
  void _showSetReminderBottomSheet(BuildContext context,
      {Map<String, dynamic>? alarm}) async {
    List<bool> initialDays = List.filled(7, false);
    TimeOfDay initialTime = const TimeOfDay(hour: 5, minute: 0);
    String initialTitle = "";

    if (alarm != null) {
      initialTitle = alarm['title'];
      initialTime = _parseTime(alarm['time']);

      List<String> alarmDays = List<String>.from(alarm['recurringDays']);
      List<String> dayNames = [
        'Sat',
        'Sun',
        'Mon',
        'Tues',
        'Wed',
        'Thurs',
        'Fri'
      ];

      for (int i = 0; i < dayNames.length; i++) {
        if (alarmDays.contains(dayNames[i])) {
          initialDays[i] = true;
        }
      }
    }

    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SetReminderBottomSheet(
        initialTime: initialTime,
        initialDays: initialDays,
        initialTitle: initialTitle, // Pass title for editing
      ),
    );

    if (result != null) {
      String title = result['title']?.trim() ?? '';
      List<bool> days = result['days'] ?? List.filled(7, false);
      TimeOfDay time = result['time'] ?? TimeOfDay.now();

      if (title.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Title cannot be empty')),
        );
        return;
      }

      if (alarm != null) {
        _updateAlarm(alarm['_id'], title, days, time); // ✅ Call update function
      } else {
        _sendReminderData(title, days, time); // Add new reminder
      }
    }
  }

  /// Send reminder data to the backend
  void _sendReminderData(String title, List<bool> days, TimeOfDay time) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/add";

    List<String> selectedDays = [];
    List<String> dayNames = [
      'Sat',
      'Sun',
      'Mon',
      'Tues',
      'Wed',
      'Thurs',
      'Fri'
    ];

    for (int i = 0; i < days.length; i++) {
      if (days[i]) {
        selectedDays.add(dayNames[i]);
      }
    }

    // ✅ Convert TimeOfDay to "6:00 AM"
    String formattedTime =
        "${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')} ${time.period == DayPeriod.am ? "AM" : "PM"}";

    Map<String, dynamic> data = {
      'title': title,
      'recurringDays': selectedDays,
      'time': formattedTime, //  Send in "6:00 AM" format
    };

    print("Sending Data to Backend: $data");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print("📥 Response from Backend: ${response.body}");

      if (response.statusCode == 201) {
        print("Reminder successfully created!");
        _fetchAlarms();
      } else {
        print("Failed to create reminder: ${response.body}");
      }
    } catch (e) {
      print("Error sending data: $e");
    }
  }

  /// Delete an alarm
  void _deleteAlarm(String id) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/delete";

    try {
      final response = await http.delete(
        Uri.parse("$apiUrl/$id"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("Alarm deleted successfully");
        _fetchAlarms(); // Refresh alarms after deletion
      } else {
        print("Failed to delete alarm: ${response.body}");
      }
    } catch (e) {
      print("Error deleting alarm: $e");
    }
  }

  void _updateAlarm(
      String id, String title, List<bool> days, TimeOfDay time) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/update";

    List<String> selectedDays = [];
    List<String> dayNames = [
      'Sat',
      'Sun',
      'Mon',
      'Tues',
      'Wed',
      'Thurs',
      'Fri'
    ];

    for (int i = 0; i < days.length; i++) {
      if (days[i]) {
        selectedDays.add(dayNames[i]);
      }
    }

    // ✅ Convert TimeOfDay to "6:00 AM"
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
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print("Alarm updated successfully");
        _fetchAlarms(); // Refresh alarms after update
      } else {
        print("Failed to update alarm: ${response.body}");
      }
    } catch (e) {
      print("Error updating alarm: $e");
    }
  }

  void _toggleToDoStatus(String id, bool currentStatus) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/toggle-todo";

    Map<String, dynamic> data = {
      'isToDo': !currentStatus, // Toggle the status
    };

    try {
      final response = await http.put(
        Uri.parse("$apiUrl/$id"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print("To-do status updated successfully");
        _fetchAlarms(); // Refresh alarms after updating
      } else {
        print("Failed to update To-do status: ${response.body}");
      }
    } catch (e) {
      print("Error updating To-do status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _loading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  const Expanded(
                    child: Text("Alerms", style: TextStyle(color: AppColors.primaryColor,fontSize: 18)),
                  ),
                  IconButton(
                      onPressed: () => _showSetReminderBottomSheet(context),
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.primaryColor,
                        size: 30,
                      ))
                ],
              ),
            ),
            const Divider(),
            Card(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: AppColors.lightBlue,
              elevation: 0,
              child: ListTile(
                title: const Text(
                  "Alarm 1",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Every Day"), Text("6:00 AM")],
                ),
                trailing: PopupMenuButton<int>(
                  onSelected: (value) {
                    if (value == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Set as To-do selected")));
                    } else if (value == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Edit selected")));
                    } else if (value == 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Delete selected")));
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  itemBuilder: (BuildContext context) => const [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline,
                              color: Colors.orange),
                          SizedBox(width: 10),
                          Text("Set as To-do"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.black),
                          SizedBox(width: 10),
                          Text("Edit"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 10),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert), // Three-dot icon
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
