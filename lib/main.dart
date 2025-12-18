// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydesign/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:mydesign/login/login_screen.dart';
import 'package:mydesign/my_app/cubit/focus_cubit.dart';
import 'package:mydesign/my_app/signin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => FocusCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: const LoginScreen(),
        // home: const SigninScreen(),
        home: FloatingBottomNavBar(),
      ),
    );
  }
}
