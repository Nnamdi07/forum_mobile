import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/login_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:forum/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      title: 'Forun App',
      debugShowCheckedModeBanner: false,
      home: token == null ? const LoginPage() : const HomePage(),
    );
  }
}
