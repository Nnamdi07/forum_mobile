import 'package:flutter/material.dart';
import 'package:forum/models/post_model.dart';
import 'package:forum/views/post_details.dart';
import 'package:get/get.dart';
import 'package:forum/controllers/postController.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());

  // Function to toggle the liked status of a post
  void _toggleLike() async {
    await _postController.likePost(widget.post.id);
    if (mounted) {
      // Ensure the widget is still mounted before calling setState
      setState(() {
        // Toggle the like status of the post
        widget.post.liked = !(widget.post.liked ?? false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.user!.name!),
          Text(
            widget.post.user!.email!,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(widget.post.content!),
          Row(
            children: [
              IconButton(
                onPressed: _toggleLike,
                icon: Icon(
                  Icons.thumb_up,
                  color: (widget.post.liked ?? false)
                      ? Colors.blue
                      : Colors.black, // Update color based on like status
                ),
              ),
              IconButton(
                onPressed: () {
                  // Navigate to post details page
                  Get.to(() => PostDetails(
                        post: widget.post,
                      ));
                },
                icon: const Icon(Icons.comment),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
