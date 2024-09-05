import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Forun App',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
