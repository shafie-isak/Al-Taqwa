import 'dart:convert';

import 'package:al_taqwa/Screens/auth/signin.dart';
import 'package:al_taqwa/Screens/home/home.dart';
import 'package:al_taqwa/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  var isloading = false.obs;

  var token = ''.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var baseUrl = 'http://10.0.2.2:5000/api/auth';

  Future<void> LoginUser() async {
    final Map<String, String> body = {
      'email': emailController.text,
      'password': passwordController.text
    };

    try {
      isloading.value = true;
      final response = await http.post(Uri.parse('$baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      isloading.value = false;

      print(response.statusCode);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        token.value = responseData['token'] ?? '';
        Get.snackbar('Success', 'Login Successful!😀🙌',
            snackPosition: SnackPosition.TOP);

        Get.to(const AlTaqwa());
      } else {
        Get.snackbar('Erorr', 'Login Failed!😟',
            snackPosition: SnackPosition.TOP);

      }
    } catch (e) {
      Get.snackbar('Erorr', 'Erorr: $e', snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> SignUp() async {
    final Map<String, String> body = {
      'email': emailController.text,
      'username': nameController.text,
      'password': passwordController.text
    };
    try {
      isloading.value = true;

      final response = await http.post(Uri.parse('$baseUrl/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));

        isloading.value = false;

        print("is calling 😀");


      if(response.statusCode == 201){
        Get.snackbar('Success', 'Registred Successful!😀🙌',
            snackPosition: SnackPosition.TOP);
            Get.put(const LogIn());

            print("success");
            Get.to(const LogIn());
      }
      else{
        Get.snackbar('Erorr', 'Registration Failed!😟',
            snackPosition: SnackPosition.TOP);

             print("failde");
      }
      
    } catch (e) {
      Get.snackbar('Erorr', 'Erorr: $e',
            snackPosition: SnackPosition.TOP);
    }
  }
}
