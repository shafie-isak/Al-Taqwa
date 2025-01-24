import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';

class SetReminderBottomSheet extends StatefulWidget {
  final TimeOfDay initialTime;
  final List<bool> initialDays;

  const SetReminderBottomSheet({
    super.key,
    required this.initialTime,
    required this.initialDays,
  });

  @override
  State<SetReminderBottomSheet> createState() => _SetReminderBottomSheetState();
}

class _SetReminderBottomSheetState extends State<SetReminderBottomSheet> {
  late List<bool> selectedDays;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDays = widget.initialDays;
    selectedTime = widget.initialTime;
  }

  void _pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = ['Sat', 'Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri'];

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment(0, 0),
            child: Text(
              'Set Alarm',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Days:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: List.generate(days.length, (index) {
              return ChoiceChip(
                label: Text(days[index]),
                selected: selectedDays[index],
                onSelected: (bool selected) {
                  setState(() {
                    selectedDays[index] = selected;
                  });
                },
                selectedColor: AppColors.secondaryColor,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: selectedDays[index]
                      ? AppColors.white
                      : AppColors.primaryColor,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          const Text(
            'Set a Time:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _pickTime(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightBlue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTime.format(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Icon(Icons.access_time),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, {
                      'days': selectedDays,
                      'time': selectedTime,
                    });
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
