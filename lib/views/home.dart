import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'widgets/post_field.dart';
import 'widgets/post_data.dart';
import 'package:get/get.dart';
import 'package:forum/controllers/postController.dart'; // Corrected import path

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  void _clearInputs() {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var token = box.read('token');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum Application'),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align items to the start
            children: [
              PostField(
                hintText: "What are you thinking?",
                controller: _textController,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 10.0),
                ),
                onPressed: () async {
                  await _postController.createPost(
                      content: _textController.text.trim());
                  _clearInputs();
                  _postController.getAllPosts();

                  // Add your post logic here
                },
                child: Obx(() {
                  return _postController.isLoading.value
                      ? const CircularProgressIndicator()
                      : Text('Post');
                }),
              ),
              const SizedBox(height: 30),
              const Text('Posts'),
              const SizedBox(height: 20),
              Obx(() {
                return _postController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _postController.posts.value.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              PostData(
                                post: _postController.posts.value[index],
                              ),
                              const SizedBox(
                                  height: 20), // Add space between each post
                            ],
                          );
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
