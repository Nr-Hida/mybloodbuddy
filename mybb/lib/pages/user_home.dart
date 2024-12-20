import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mybb/pages/user_homepage.dart';
import 'package:mybb/pages/user_book_appointment.dart';
import 'package:mybb/pages/user_settings.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    UserHomepage(),
    UserBookAppointment(),
    UserSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // actions: [
          //   IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          // ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
              const SizedBox(width: 8),
              const Text("Hi, Muhammad Aiman", style: TextStyle(
                color: Colors.white
              )),
            ],
          ),
          backgroundColor: Color(0xFFBC3B3B)
        ),
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
              // color: Colors.white,
              activeColor: Colors.black,
              tabBackgroundColor: Color(0xFFBC3B3B)
              tabMargin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),
              gap: 8,
              tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.calendar_today,
                text: "Appointments",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
            ]),
          ),
        ),
        backgroundColor: Colors.white,
        body: _pages[_selectedIndex],
      ),
    );
  }
}