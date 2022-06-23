import 'package:flutter/material.dart';
import 'package:india_today_assignment/colors.dart';
import 'package:india_today_assignment/my_profile/myProfileTab.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,  appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: orangeColor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Image.asset(
            'images/icon.png',
            height: 56,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                onPressed: onLogoutPressed,
                child: const Text(
                  'Logout',
                  style: TextStyle(color: orangeColor),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: orangeColor),
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: <Tab>[
              Tab(
                child: Text(
                  'My Profile',
                  style: TextStyle(color: orangeColor),
                ),
              ),
              Tab(
                child: Text('Order History'),
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          const MyProfileTab(),
          Container(),
        ]),
      ),
    );
  }

  void onLogoutPressed() {}
}
