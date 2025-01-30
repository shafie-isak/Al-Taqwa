import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_taqwa/colors.dart';
import 'package:al_taqwa/controllers/todoController.dart';

class AllTodo extends StatelessWidget {
  final String filter;
  final ToDoController todoController = Get.find();

  AllTodo({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Map<String, dynamic>> filteredTodos = [];
      if (filter == 'all') {
        filteredTodos = todoController.todos;
      } else if (filter == 'completed') {
        filteredTodos = todoController.completedTodos;
      } else if (filter == 'uncompleted') {
        filteredTodos = todoController.uncompletedTodos;
      }

      return todoController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : filteredTodos.isEmpty
              ? const Center(child: Text("No To-Dos available", style: TextStyle(fontSize: 16)))
              : ListView.builder(
                  itemCount: filteredTodos.length,
                  itemBuilder: (context, index) {
                    final todo = filteredTodos[index];

                    return Card(
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      color: AppColors.lightBlue,
                      elevation: 0,
                      child: ListTile(
                        title: Text(
                          todo['title'],
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Days: ${todo['recurringDays'].join(", ")}"),
                            Text("Time: ${todo['time']}"),
                          ],
                        ),
                        leading: Checkbox(
                          value: todo['completed'],
                          onChanged: (value) {
                            todoController.toggleCompleted(todo['_id'], todo['completed']);
                          },
                        ),
                      ),
                    );
                  },
                );
    });
  }
}