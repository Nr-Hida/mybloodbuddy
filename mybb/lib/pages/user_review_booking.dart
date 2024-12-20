import "package:flutter/material.dart";
import "package:mybb/components/my_button.dart";
import "package:mybb/components/my_timeblock.dart";
import 'package:mybb/components/my_appbar.dart';

class UserReviewBooking extends StatefulWidget {
  const UserReviewBooking({super.key});

  @override
  State<StatefulWidget> createState() => _UserReviewBookingState();
}

class _UserReviewBookingState extends State<UserReviewBooking> {
  final int totalMonthsInAYear = 12;
  final _defaultDateTime = DateTime.now().toString();
  DateTime _dateTime = DateTime.now();
  String _timeBlock = "No time chosen yet.";

  // show date picker method
  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 1, (DateTime.now().month + 3) % totalMonthsInAYear, DateTime.now().day)
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  // select time block
  void selectTimeBlock(String value) {
    setState(() {
      _timeBlock = value;
    });
  }

  String _getMonthName(int month) {
    if (month == 1) {
      return "January";
    } else if (month == 2) {
      return "February";
    } else if (month == 3) {
      return "March";
    } else if (month == 4) {
      return "April";
    } else if (month == 5) {
      return "May";
    } else if (month == 6) {
      return "June";
    } else if (month == 7) {
      return "July";
    } else if (month == 8) {
      return "August";
    } else if (month == 9) {
      return "September";
    } else if (month == 10) {
      return "October";
    } else if (month == 11) {
      return "November";
    } else {
      return "December";
    }
  }
  
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
          title: const Text("Hi, Muhammad Aiman", style: TextStyle(
            color: Colors.white
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const ListTile(
                title: Text("Review Your Booking", style: TextStyle(
                  fontWeight: FontWeight.w900
                )),
              ),
              const ListTile(
                title: Text("Please review your appointment details before confirming."),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(right: 25.0, bottom: 25.0, top: 25.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFFBC3B3B)
                      width: 5.0,
                      strokeAlign: BorderSide.strokeAlignCenter
                    )
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Table(
                  children: const [
                    TableRow(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Donor:",
                              style: TextStyle(
                                color: Color(0xff000080),
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.start
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Muhd Aiman Bin Azhar", style: TextStyle(
                              color: Color(0xff000080),
                              fontWeight: FontWeight.bold
                            ))
                          ],
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        Column(
                          children: [
                            Text("Location:", style: TextStyle(
                                color: Color(0xff000080),
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.start
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Hospital Orang Asli Gombak, KM 24 Gombak, 53100, Kuala Lumpur.", style: TextStyle(
                              color: Color(0xff000080),
                              fontWeight: FontWeight.bold
                            ))
                          ],
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        Column(
                          children: [
                            Text("Date:", style: TextStyle(
                              color: Color(0xff000080),
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.start)
                          ],
                        ),
                        Column(
                          children: [
                            Text("17th May 2024", style: TextStyle(
                              color: Color(0xff000080),
                              fontWeight: FontWeight.bold
                            ))
                          ],
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        Column(
                          children: [
                            Text("Time:", style: TextStyle(
                              color: Color(0xff000080),
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.start)
                          ],
                        ),
                        Column(
                          children: [
                            Text("3 - 4 PM", style: TextStyle(
                              color: Color(0xff000080),
                              fontWeight: FontWeight.bold
                            ))
                          ],
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        Column(
                          children: [
                            Text("Appointment ID:", style: TextStyle(
                              color: Color(0xff000080),
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.start)
                          ],
                        ),
                        Column(
                          children: [
                            Text("0001", style: TextStyle(
                              color: Color(0xff000080),
                              fontWeight: FontWeight.bold
                            ))
                          ],
                        ),
                      ]
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100.0),
              MyButton(text: "Book Now", onTap: () {
                Navigator.pushNamed(context, "login");
              }),
            ],
          )
        )
      )
    );
  }
}