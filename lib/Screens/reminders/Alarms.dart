import 'package:al_taqwa/controllers/reminder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_taqwa/Screens/reminders/set_reminder_bottom_sheet.dart';
import 'package:al_taqwa/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Alarms extends StatelessWidget {
  final ReminderController _reminderController = Get.put(ReminderController());

  Alarms({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Skeletonizer(
        enabled: _reminderController.isLoading.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Alarms",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showSetReminderBottomSheet(context),
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              ..._reminderController.alarms.map((alarm) {
                return Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: AppColors.lightBlue,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      alarm['title'],
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text("Time: ${_formatTime(alarm['time'])}"),
                    trailing: PopupMenuButton<int>(
                      onSelected: (value) {
                        if (value == 1) {
                          _reminderController.toggleToDoStatus(
                              alarm['_id'], alarm['isToDo']);
                        }
                        if (value == 2) {
                          _showSetReminderBottomSheet(context, alarm: alarm);
                        }
                        if (value == 3) {
                          _reminderController.deleteAlarm(alarm['_id']);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(
                                alarm['isToDo']
                                    ? Icons.remove_circle_outline
                                    : Icons.check_circle_outline,
                                color: alarm['isToDo']
                                    ? Colors.red
                                    : Colors.orange,
                              ),
                              const SizedBox(width: 10),
                              Text(alarm['isToDo']
                                  ? "Remove To-do"
                                  : "Set as To-do"),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Edit"),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
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
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }

  void _showSetReminderBottomSheet(BuildContext context,
      {Map<String, dynamic>? alarm}) async {
    TimeOfDay initialTime = const TimeOfDay(hour: 5, minute: 0);
    String initialTitle = "";

    if (alarm != null) {
      initialTitle = alarm['title'];
      initialTime =
          _parseTime(alarm['time']); 
    }

    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SetReminderBottomSheet(
        initialTime: initialTime,
        initialTitle: initialTitle,
      ),
    );

    if (result != null) {
      String title = result['title']?.trim() ?? '';
      TimeOfDay time = result['time'] ?? TimeOfDay.now();

      if (title.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Title cannot be empty')),
        );
        return;
      }

      if (alarm != null) {
        _reminderController.updateAlarm(alarm['_id'], title, time);
      } else {
        _reminderController.sendReminderData(title, time);
      }
    }
  }

  String _formatTime(String timeString) {
    if (timeString.isEmpty) return "Not Set";

    try {
      DateTime parsedTime = DateTime.parse(timeString).toLocal();

      int hour = parsedTime.hour > 12 ? parsedTime.hour - 12 : parsedTime.hour;
      hour = hour == 0 ? 12 : hour;
      String period = parsedTime.hour >= 12 ? "PM" : "AM";

      String formattedTime =
          "$hour:${parsedTime.minute.toString().padLeft(2, '0')} $period";
      return formattedTime;
    } catch (e) {
      return "Invalid Time";
    }
  }

  TimeOfDay _parseTime(String timeString) {
    try {
      DateTime parsedTime = DateTime.parse(timeString).toLocal();
      return TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);
    } catch (e) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
  }
}