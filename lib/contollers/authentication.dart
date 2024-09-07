import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:forum/constants/constant.dart';
import 'dart:convert'; // To handle JSON decoding
import 'dart:developer'; // For debugPrint

class AuthenticationController extends GetxController {
  final isLoading = false.obs;

  Future register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'name': name,
        'password': password,
      };

      var response = await http.post(
        Uri.parse(url + '/register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;

        // Show success toast
        Get.snackbar(
          "Success", // Title of the message
          "Registration successful!", // Message content
          snackPosition: SnackPosition.TOP, // Position on the screen
          backgroundColor: Colors.green, // Background color
          colorText: Colors.white, // Text color
          margin: const EdgeInsets.all(16.0), // Padding around the toast
          duration:
              const Duration(seconds: 3), // How long it should be displayed
        );

        print(json.decode(response.body));

        return response; // Return the response to handle in the UI
      } else {
        isLoading.value = false;
        String errorMessage = 'Registration failed';

        // If registration fails, get the error message from the response
        if (response.body.isNotEmpty) {
          var responseData = json.decode(response.body);
          if (responseData['error'] != null) {
            errorMessage =
                responseData['error']; // Extract the actual error message
          }
        }

        // Show success toast
        Get.snackbar(
          "Something is wrong", // Title of the message
          errorMessage, // Message content
          snackPosition: SnackPosition.TOP, // Position on the screen
          backgroundColor: Colors.red, // Background color
          colorText: Colors.white, // Text color
          margin: const EdgeInsets.all(16.0), // Padding around the toast
          duration:
              const Duration(seconds: 4), // How long it should be displayed
        );

        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
