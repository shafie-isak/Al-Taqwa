import 'package:al_taqwa/Screens/reminders/all_todos.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';


class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: AppColors.lightBlue,
            child: const TabBar(
              dividerColor: AppColors.primaryColor,
              tabs: [
                Tab(text: "All"),
                Tab(text: "Completed"),
                Tab(text: "UnCompleted"),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                AllTodo(),
                AllTodo(),
                AllTodo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
