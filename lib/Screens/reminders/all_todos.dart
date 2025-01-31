import 'package:al_taqwa/controllers/reminder_controller.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTodo extends StatelessWidget {
  final String filterType; // Filter (all, completed, uncompleted)
  const AllTodo({super.key, required this.filterType});

  @override
  Widget build(BuildContext context) {
    final ReminderController reminderController = Get.find();

    return Obx(() {
      List<Map<String, dynamic>> filteredTodos = reminderController.todos
          .where((todo) {
            if (filterType == "completed") return todo['isCompleted'] == true;
            if (filterType == "uncompleted") return todo['isCompleted'] == false;
            return true; // Show all
          })
          .toList();

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: filteredTodos.length,
          itemBuilder: (context, index) {
            var todo = filteredTodos[index];
            return Card(
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
              color: AppColors.lightBlue,
              elevation: 0,
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {
                    reminderController.toggleCompleted(todo['_id'], todo['isCompleted']);
                  },
                  child: Icon(
                    todo['isCompleted'] ? Icons.check_box : Icons.check_box_outline_blank,
                    size: 35,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: Text(
                  todo['title'],
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text("Time: ${_formatTime(todo['time'])}"),
              ),
            );
          },
        ),
      );
    });
  }

  /// *Helper function to format time into 12-hour format*
  String _formatTime(String timeString) {
    if (timeString.isEmpty) return "Not Set";
    try {
      DateTime parsedTime = DateTime.parse(timeString).toLocal();
      int hour = parsedTime.hour > 12 ? parsedTime.hour - 12 : parsedTime.hour;
      hour = hour == 0 ? 12 : hour; // Handle midnight case (0 -> 12 AM)
      String period = parsedTime.hour >= 12 ? "PM" : "AM";
      return "$hour:${parsedTime.minute.toString().padLeft(2, '0')} $period";
    } catch (e) {
      return "Invalid Time";
    }
  }
}