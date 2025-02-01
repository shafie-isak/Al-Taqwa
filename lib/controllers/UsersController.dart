import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:al_taqwa/Screens/auth/signin.dart';
import 'package:al_taqwa/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class UsersController extends GetxController {
  var isloading = false.obs;

  var token = ''.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  var baseUrl = 'http://10.0.2.2:5000/api/auth';

  Future<void> LoginUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required 😟',
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar('Error', 'Invalid email format! 😟',
          snackPosition: SnackPosition.TOP);
      return;
    }

    final Map<String, String> body = {
      'email': email,
      'password': password,
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

        userName.value = responseData['user']['username'] ?? '';
        userEmail.value = responseData['user']['email'] ?? '';

        Get.snackbar('Success', 'Login Successful! 😀🙌',
            snackPosition: SnackPosition.TOP);

        Get.to(const AlTaqwa());

        emailController.clear();
        passwordController.clear();
      } else if (response.statusCode == 404) {
        Get.snackbar('Error', 'User not found! Please Sign Up! 😟',
            snackPosition: SnackPosition.TOP);
      } else if (response.statusCode == 401) {
        Get.snackbar('Error', 'Incorrect password! 😟',
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar('Error', 'Login Failed! 😟',
            snackPosition: SnackPosition.TOP);
      }
    } on SocketException catch (e) {
      Get.snackbar('Erorr', 'Connection error: $e', snackPosition: SnackPosition.TOP);
    } on TimeoutException catch (e) {
      Get.snackbar('Erorr', 'Connection error: $e', snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar('Erorr', 'Erorr: $e', snackPosition: SnackPosition.TOP);
    } finally {
      isloading.value = false;
    }
  }

  Future<void> SignUp() async {
    final email = emailController.text;
    final username = nameController.text;
    final password = passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'All fields are required 😟',
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar('Error', 'Invalid email format! 😟',
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (password.length < 4) {
      Get.snackbar('Error', 'Password must be at least 4 characters long! 😟',
          snackPosition: SnackPosition.TOP);
      return;
    }

    final Map<String, String> body = {
      'email': email,
      'username': username,
      'password': password
    };

    try {
      isloading.value = true;

      final response = await http.post(Uri.parse('$baseUrl/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));

      isloading.value = false;

      print("is calling 😀");

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Registred Successful!😀🙌',
            snackPosition: SnackPosition.TOP);

        Get.put(const LogIn());

        emailController.clear();
        nameController.clear();
        passwordController.clear();

        print("success");
        Get.to(const LogIn());
      } else if (response.statusCode == 409) {
        Get.snackbar('Error', 'User already exists! 😟',
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar('Erorr', 'Registration Failed!😟',
            snackPosition: SnackPosition.TOP);

        print("failde");
      }
    } on SocketException catch (e) {
      Get.snackbar('Erorr', 'Connection error: $e', snackPosition: SnackPosition.TOP);
    } on TimeoutException catch (e) {
      Get.snackbar('Erorr', 'Connection error: $e', snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar('Erorr', 'Erorr: $e', snackPosition: SnackPosition.TOP);
    } finally {
      isloading.value = false;
    }
  }

  void LogoutUser() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          "Logout",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        content: const Text("Are you sure you want to log out?",
            style: TextStyle(fontSize: 16)),
        actions: [
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.cancel, color: Colors.black54),
                label: const Text("No"),
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton.icon(
                onPressed: () {
                  token.value = '';
                  emailController.clear();
                  passwordController.clear();

                  Get.snackbar('Success', 'Logged out successfully! 😀',
                      snackPosition: SnackPosition.TOP);

                  Get.offAll(const LogIn());
                },
                icon: const Icon(Icons.exit_to_app),
                label: const Text("Yes"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}