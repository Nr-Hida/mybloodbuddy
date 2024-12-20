import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mybb/components/my_appbar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybb/pages/user_homepage.dart';
import 'package:mybb/pages/user_book_appointment.dart';
import 'package:mybb/pages/user_settings.dart';
import 'package:mybb/utils/enums.dart';
import "package:mybb/utils/user.dart" as mybb_user;
import "package:mybb/utils/appointment.dart";
import 'package:mybb/components/mybloodbuddy_logo.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome>
{
  late Future<mybb_user.User> user;
  late Future<Appointment> upcomingApp;
  late Future<int> appCount;

  final int totalMonthsInAYear = 12;
  // final hospitals = [
  //   "HOA: Hospital Orang Asli",
  //   "HSB: Hospital Sungai Buloh",
  //   "HKL: Hospital Kuala Lumpur",
  // ];
  final hospitals = [
    "Hospital Orang Asli",
    "Hospital Sungai Buloh",
    "Hospital Kuala Lumpur",
  ];
  String _chosenHospital = "No hospital chosen yet.";
  DateTime _dateTime = DateTime(2020);
  String _timeslot = "No time chosen yet.";
  
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    Text(""), // placeholder for UserHomepage()
    Text(""),
    UserSettings(),
  ];

  @override
  void initState() {
    super.initState();
    user = mybb_user.fetchUser();
    upcomingApp = fetchUpcomingAppointment();
    appCount = countAppointments();
  }

  // show date picker method
  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 1, (DateTime.now().month + 3) % totalMonthsInAYear, DateTime.now().day),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  // show time picker method
  // void _showTimePicker() {
  //   showTimePicker(context: context, initialTime: _timeSlot).then((value) {
  //     setState(() {
  //       _timeSlot = value!;
  //     });
  //   });
  // }

  // select time block
  void selectTimeslot(String value) {
    setState(() {
      _timeslot = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget renderHospitals() {
      return Column(
        children: hospitals.map((hospital) => {
          ListTile(
            title: Text(hospital),
            onTap: () {
              setState(() {
                // _chosenHospital = hospital.split(":")[0];
                _chosenHospital = hospital;
              });
              Navigator.pop(context);
            },
            leading: const Icon(Icons.local_hospital),
          ),
        }.first).toList(),
      );
    }
    
    void selectHospitalDialog() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog.fullscreen(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 15),
              const ListTile(
                title: Text("Please select the most convenient hospital\nfor you to reach", style: TextStyle(
                  fontWeight: FontWeight.w900
                )),
                leading: Icon(Icons.pin_drop),
              ),
              renderHospitals(),
            ],
          ),
        ),
      );
    }
    
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppbar(
          mainAxisAlignment: MainAxisAlignment.center,
          leadingIcon: MyBloodBuddyLogo(
            imageFilename: "mybloodbuddy.png",
            includeTitle: false,
          ),
          title: Text(
            "MyBloodBuddy",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
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
              // activeColor: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: Color(0xFFBC3B3B),
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
        // Use FutureBuilder if building UserHomepage() and UserBookAppointment()
        // otherwise, just the page widget
        body: _selectedIndex == 2
        ?
        _pages[_selectedIndex]
        :
        FutureBuilder<mybb_user.User>(future: user, builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (_selectedIndex == 0) {
              return UserHomepage(
                fullName: snapshot.data!.fullName,
                bloodType: formatBloodType(snapshot.data!.bloodType),
                icNumber: snapshot.data!.ic,
                donationCount: snapshot.data!.donationCount,
                weight: snapshot.data!.weight,
                height: snapshot.data!.height,
                upcomingApp: upcomingApp,
              );
            } else if (_selectedIndex == 1) {
              return UserBookAppointment(
                chosenHospital: _chosenHospital,
                selectHospitalDialog: selectHospitalDialog,
                appCount: appCount,
                chosenDateTime: _dateTime,
                showDatePicker: _showDatePicker,
                chosenTimeslot: _timeslot,
                selectTimeslot: selectTimeslot,
                fullName: snapshot.data!.fullName,
                bloodType: formatBloodType(snapshot.data!.bloodType),
                icNumber: snapshot.data!.ic,
                weight: snapshot.data!.weight,
                height: snapshot.data!.height,
              );
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}: ${snapshot.stackTrace}');
          }
          
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        })
      ),
    );
  }
}