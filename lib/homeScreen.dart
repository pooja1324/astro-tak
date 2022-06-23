import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_today_assignment/ask_questions/AskQuestionBloc.dart';
import 'package:india_today_assignment/ask_questions/askQuestionScreen.dart';
import 'package:india_today_assignment/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 2;
  final List<Widget> bodyList = [
    Container(),
    Container(),
    BlocProvider<AskQuestionBloc>(
      create: (context) {
        return AskQuestionBloc();
      },
      child: const AskQuestionScreen(),
    ),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedItemColor: orangeColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/home.png',
                color: currentIndex == 0 ? orangeColor : Colors.grey,
                height: 24,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/talk.png',
                color: currentIndex == 1 ? orangeColor : null,
                height: 24,
              ),
              label: 'Talk'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/ask.png',
                color: currentIndex == 2 ? orangeColor : null,
                height: 24,
              ),
              label: 'Ask Question'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/reports.png',
                color: currentIndex == 3 ? orangeColor : null,
                height: 24,
              ),
              label: 'Reports'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/chat.png',
                color: currentIndex == 4 ? orangeColor : null,
                height: 24,
              ),
              label: 'Chat'),
        ],
      ),
    );
  }
}
