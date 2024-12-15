import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mybb/components/my_appbar.dart';
import 'package:mybb/pages/admin_homepage.dart';
import 'package:mybb/pages/admin_settings.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
{
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    AdminHomepage(),
    AdminSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppbar(
          mainAxisAlignment: MainAxisAlignment.center,
          leadingIcon: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 5
              )
            ),
            child: const Icon(Icons.person),
          ),
          title: const Text("Hi, Admin", style: TextStyle(
            color: Colors.white
          )),
        ),
        // backgroundColor: Colors.white,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          color: Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Colors.grey.shade200,
              // activeColor: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.red.shade900,
              tabMargin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),
              gap: 5,
              tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
            ]),
          ),
        ),
      )
    );
  }
}