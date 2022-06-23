import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_today_assignment/ask_questions/AskQuestionBloc.dart';
import 'package:india_today_assignment/ask_questions/askQuestionScreen.dart';
import 'package:india_today_assignment/colors.dart';
import 'package:india_today_assignment/homeScreen.dart';
import 'package:india_today_assignment/my_profile/myProfileBloc.dart';
import 'package:india_today_assignment/my_profile/myProfileScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.orange),
      routes: {
        'profile': (context) => BlocProvider<MyProfileBloc>(
              create: (context) {
                return MyProfileBloc();
              },
              child: const MyProfileScreen(),
            ),
      },
      home: const HomeScreen(),
    );
  }
}
