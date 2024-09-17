import 'package:flutter/material.dart';
import 'package:forum/controllers/postController.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import 'widgets/post_data.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.user!.name!),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              PostData(post: widget.post),

              const SizedBox(height: 20),

              // Obx(() {
              //   return _postController.isLoading.value
              //       ? Center(
              //           child: CircularProgressIndicator(),
              //         )
              //       : ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: _postController.comments.value.length,
              //           itemBuilder: (context, index) {
              //             return Column(
              //               children: [
              //                 PostData(
              //                   post: _postController.posts.value[index],
              //                 ),
              //                 const SizedBox(
              //                     height: 20), // Add space between each post
              //               ],
              //             );
              //           },
              //         );
              // }),

              Container(
                  height: 300,
                  width: double.infinity,
                  child: Obx(() {
                    return _postController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: _postController.comments.value.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  _postController
                                      .comments.value[index].user!.name!,
                                  style: TextStyle(fontSize: 16),
                                ),
                                subtitle: Text(
                                  _postController
                                      .comments.value[index].content!,
                                  style: TextStyle(fontSize: 12),
                                ),
                              );
                            });
                  })),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: TextFormField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: 'Write a comment ...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Moved SizedBox here
              ElevatedButton(
                onPressed: () {
                  // Your button logic here
                },
                child: const Text('Submit'), // Added child widget to the button
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
