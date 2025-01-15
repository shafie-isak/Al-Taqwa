import 'dart:async';
import 'package:al_taqwa/Screens/reminders/set_reminder_bottom_sheet.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Alarms extends StatefulWidget {
  const Alarms({super.key});

  @override
  State<Alarms> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _loading = false;
      });
    });
  }

   void _showSetReminderBottomSheet(BuildContext context) async {
    List<bool> initialDays = List.filled(7, false);
    TimeOfDay initialTime = const TimeOfDay(hour: 5, minute: 0);

    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => SetReminderBottomSheet(
        initialTime: initialTime,
        initialDays: initialDays,
      ),
    );

    if (result != null) {
      // Handle the result from the bottom sheet
      print('Selected Days: ${result['days']}');
      print('Selected Time: ${result['time'].format(context)}');
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
              child:  Row(
                children: [
                  Expanded(
                    child: Text("Alerms",
                        style: TextStyle(color: Colors.grey)),
                  ),
                  IconButton(onPressed: () => _showSetReminderBottomSheet(context), icon: Icon(Icons.add, color: AppColors.primaryColor,))
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
                          SnackBar(content: Text("Set as To-do selected")));
                    } else if (value == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Edit selected")));
                    } else if (value == 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Delete selected")));
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  itemBuilder:  (BuildContext context) => const [
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
