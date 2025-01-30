import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ToDoController extends GetxController {
  var todos = <Map<String, dynamic>>[].obs; // Reactive list of To-dos
  var isLoading = true.obs; // Reactive loading state

  @override
  void onInit() {
    fetchToDos();
    super.onInit();
  }

  /// Fetch all To-dos from the database where isToDo is true
  Future<void> fetchToDos() async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/get-todos";
    try {
      final response = await http.get(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        todos.value =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        print("Failed to fetch todos: ${response.body}");
      }
    } catch (e) {
      print("Error fetching todos: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle the completed status of a to-do
  Future<void> toggleCompleted(String id, bool isCompleted) async {
    const String apiUrl = "http://10.0.2.2:5000/api/reminders/toggle-complete";
    Map<String, dynamic> data = {
      'completed': !isCompleted, // Toggle the status
    };

    try {
      final response = await http.put(Uri.parse("$apiUrl/$id"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        fetchToDos(); // Refresh the to-do list
      } else {
        print("Failed to update To-do status: ${response.body}");
      }
    } catch (e) {
      print("Error updating To-do status: $e");
    }
  }

  // Get completed todos
  List<Map<String, dynamic>> get completedTodos =>
      todos.where((todo) => todo['completed'] == true).toList();

  // Get uncompleted todos
  List<Map<String, dynamic>> get uncompletedTodos =>
      todos.where((todo) => todo['completed'] == false).toList();
}
