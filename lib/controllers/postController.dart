import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:forum/constants/constant.dart';
import 'dart:convert';

import '../models/post_model.dart'; // To handle JSON decoding

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    // TODO: implement onInit
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse(url + '/feed/all'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var item in json.decode(response.body)['feeds']) {
          posts.value.add(PostModel.fromJson(item));
        }
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({
    required String content,
  }) async {
    try {
      isLoading.value = true;
      var data = {'content': content};

      var response = await http.post(
        Uri.parse(url + '/feed/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );
      if (response.statusCode == 201) {
        isLoading.value = false;

        // Show success toast
        Get.snackbar(
          "Success", // Title of the message
          "Post created successfully!", // Message content
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

        // Show success toast
        Get.snackbar(
          "Error", // Title of the message
          "Content is required", // Message content
          snackPosition: SnackPosition.TOP, // Position on the screen
          backgroundColor: Colors.red, // Background color
          colorText: Colors.white, // Text color
          margin: const EdgeInsets.all(16.0), // Padding around the toast
          duration:
              const Duration(seconds: 3), // How long it should be displayed
        );

        print(json.decode(response.body));

        return response; // Return the response to handle in the UI
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
