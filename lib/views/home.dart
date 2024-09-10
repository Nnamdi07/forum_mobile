import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'widgets/post_field.dart';
import 'widgets/post_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();

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
                controller: _postController,
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
                onPressed: () {
                  // Add your post logic here
                },
                child: const Text('Post'),
              ),
              const SizedBox(height: 30),
              const Text('Posts'),
              const SizedBox(height: 20),
              PostData(),
              const SizedBox(height: 20),
              PostData(),
              const SizedBox(height: 20),
              PostData(),
              const SizedBox(height: 20),
              PostData(),
              const SizedBox(height: 20),
              PostData(),
              const SizedBox(height: 20),
              PostData(),
              const SizedBox(height: 20),
              PostData(),
            ],
          ),
        ),
      ),
    );
  }
}
