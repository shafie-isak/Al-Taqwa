import 'package:flutter/material.dart';

class SetReminderBottomSheet extends StatefulWidget {
  final TimeOfDay initialTime;
  final List<bool> initialDays;

  const SetReminderBottomSheet({
    Key? key,
    required this.initialTime,
    required this.initialDays,
  }) : super(key: key);

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
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Set Reminder',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
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
                selectedColor: Colors.orange,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: selectedDays[index] ? Colors.white : Colors.black,
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
              padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${selectedTime.format(context)}',
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
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'days': selectedDays,
                    'time': selectedTime,
                  });
                },
                child: const Text('Save'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
