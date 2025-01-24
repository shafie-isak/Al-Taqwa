import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  var isloading = false.obs;

  var token = ''.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var baseUrl = 'http://localhost:5000/api/';

  Future<void> LoginUser() async {
    final Map<String, String> body = {
      'emal': emailController.text,
      'password': passwordController.text
    };

    try {
      isloading.value = true;
      final response = await http.post(Uri.parse('$baseUrl/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      isloading.value = false;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        token.value = responseData['token'] ?? '';
        Get.snackbar('Success', 'Login Successful!😀🙌',
            snackPosition: SnackPosition.BOTTOM);
      }
      else{
        Get.snackbar('Erorr', 'Login Failed!😟',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Erorr', 'Erorr: $e',
            snackPosition: SnackPosition.BOTTOM);
    }
  }
}
