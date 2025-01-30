import 'package:al_taqwa/Screens/reminders/all_todos.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_taqwa/controllers/todoController.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ToDoController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-Dos'),
          bottom: TabBar(
            dividerColor: AppColors.primaryColor,
            tabs: const [
              Tab(text: "All"),
              Tab(text: "Completed"),
              Tab(text: "UnCompleted"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllTodo(filter: 'all'),
            AllTodo(filter: 'completed'),
            AllTodo(filter: 'uncompleted'),
          ],
        ),
      ),
    );
  }
}
