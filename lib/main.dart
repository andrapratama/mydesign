import 'package:flutter/material.dart';
import 'package:mydesign/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andra Satria Pratama - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(
          0xFFF9FAFB,
        ), // Clean off-white background
        fontFamily: 'Roboto', // Pastikan font ini atau yang mirip tersedia
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
