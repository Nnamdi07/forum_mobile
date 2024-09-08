import 'package:flutter/material.dart';
import 'package:forum/views/home.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:forum/constants/constant.dart';
import 'dart:convert'; // To handle JSON decoding
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (!GetStorage().hasData('token')) {
      box.write('token', ''); // Write default value if no token exists
    }
  }

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

          // Check if there are validation errors in the 'errors' field
          if (responseData.containsKey('errors')) {
            // Collect the detailed error messages
            String errorMessages = '';

            responseData['errors'].forEach((key, value) {
              // 'value' is usually a list of error messages, so join them
              errorMessages += value.join(', ') +
                  '\n'; // Join error messages for a field and add newline
            });

            // Show error toast with the detailed validation errors
            Get.snackbar(
              "Validation Error", // Title of the message
              errorMessages
                  .trim(), // Detailed error messages, trimmed to remove the trailing newline
              snackPosition: SnackPosition.TOP, // Position on the screen
              backgroundColor: Colors.red, // Background color
              colorText: Colors.white, // Text color
              margin: const EdgeInsets.all(16.0), // Padding around the toast
              duration:
                  const Duration(seconds: 4), // How long it should be displayed
            );
          } else {
            // Show general error message if no validation errors exist
            Get.snackbar(
              "Something is wrong", // Title of the message
              responseData['message'] ??
                  'An error occurred', // Extract and display the exact error message
              snackPosition: SnackPosition.TOP, // Position on the screen
              backgroundColor: Colors.red, // Background color
              colorText: Colors.white, // Text color
              margin: const EdgeInsets.all(16.0), // Padding around the toast
              duration:
                  const Duration(seconds: 4), // How long it should be displayed
            );
          }
        }

        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };

      var response;

      try {
        // Try making the HTTP request
        response = await http.post(
          Uri.parse(url + '/login'),
          headers: {
            'Accept': 'application/json',
          },
          body: data,
        );
      } catch (e) {
        // Handle network errors or any issue during the HTTP request
        isLoading.value = false;
        Get.snackbar(
          "Network Error",
          "Please check your internet connection.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16.0),
          duration: const Duration(seconds: 4),
        );
        return;
      }

      // Check if the response is null or contains a valid status code
      if (response == null) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16.0),
          duration: const Duration(seconds: 4),
        );
        return;
      }

      // If the request was successful
      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const HomePage());

        Get.snackbar(
          "Success",
          "Login successful!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16.0),
          duration: const Duration(seconds: 3),
        );
      } else {
        isLoading.value = false;

        // Handle response error if status is not 200
        var responseData = json.decode(response.body);

        if (responseData.containsKey('errors')) {
          // Collect and display validation errors
          String errorMessages = '';
          responseData['errors'].forEach((key, value) {
            errorMessages += value.join(', ') + '\n';
          });

          Get.snackbar(
            "Validation Error",
            errorMessages.trim(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.all(16.0),
            duration: const Duration(seconds: 4),
          );
        } else {
          // Show general error message
          Get.snackbar(
            "Login Failed",
            responseData['message'] ?? 'An error occurred.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.all(16.0),
            duration: const Duration(seconds: 4),
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16.0),
        duration: const Duration(seconds: 4),
      );
      print(e.toString());
    }
  }
}
