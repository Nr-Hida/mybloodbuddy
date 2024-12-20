import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:mybb/components/my_button.dart";
// import "package:mybb/components/my_timeblock.dart";
import 'package:mybb/components/my_appbar.dart';

class UserBookingReview extends StatelessWidget {
  const UserBookingReview({super.key});

  String formatAppCount(String appCount) {
    String result = "";
    
    const maxAppIDLength = 4;
    final loopCount = maxAppIDLength - int.parse(appCount);
    for (var i = 0; i < loopCount; i++) {
      result += "0";
    }
    
    return result + appCount;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return SafeArea(
      child: Scaffold(
        appBar: const MyAppbar(
          mainAxisAlignment: MainAxisAlignment.center,
          leadingIcon: Text(""),
          title: Text("Schedule Appointment", style: TextStyle(
            color: Colors.white
          )),
        ),
        body: FutureBuilder(
          future: arguments["appCount"],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final appCount = snapshot.data!;
              
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    const ListTile(
                      title: Text("Review Your Booking", style: TextStyle(
                        fontWeight: FontWeight.w900
                      )),
                      subtitle: Text("Please review your appointment details before confirming."),
                    ),
                    // const ListTile(
                    //   title: Text("Please review your appointment details before confirming."),
                    // ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.only(right: 25.0, bottom: 25.0, top: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        border: Border(
                          left: BorderSide(
                            color: Color(0xFFBC3B3B),
                            width: 5.0,
                            strokeAlign: BorderSide.strokeAlignCenter
                          )
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Donor:",
                                      style: TextStyle(
                                        // color: Color(0xff000080),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(arguments["fullName"], style: const TextStyle(
                                    // color: Color(0xff000080),
                                    // color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                  ))
                                ],
                              ),
                            ]
                          ),
                          TableRow(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("Location:", style: TextStyle(
                                        // color: Color(0xff000080),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(arguments["chosenHospital"], style: const TextStyle(
                                    // color: Color(0xff000080),
                                    // color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                  ))
                                ],
                              ),
                            ]
                          ),
                          TableRow(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("Date:", style: TextStyle(
                                      // color: Color(0xff000080),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(arguments["chosenDateTimeString"], style: const TextStyle(
                                    // color: Color(0xff000080),
                                    // color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                  ))
                                ],
                              ),
                            ]
                          ),
                          TableRow(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("Time:", style: TextStyle(
                                      // color: Color(0xff000080),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(arguments["chosenTimeslot"], style: const TextStyle(
                                    // color: Color(0xff000080),
                                    // color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                  ))
                                ],
                              ),
                            ]
                          ),
                          TableRow(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("Appointment ID:", style: TextStyle(
                                      // color: Color(0xff000080),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(formatAppCount(appCount.toString()), style: const TextStyle(
                                    // color: Color(0xff000080),
                                    // color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                  ))
                                ],
                              ),
                            ]
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100.0),
                    MyButton(
                      text: "Book Now",
                      onTap: () => {
                        Navigator.pushNamed(
                          context,
                          "user_blood_donor_eligibility_questionnaire",
                          arguments: {
                            "chosenHospital": arguments["chosenHospital"],
                            "chosenDateTime": arguments["chosenDateTime"],
                            "chosenDateTimeString": arguments["chosenDateTimeString"],
                            "chosenTimeslot": arguments["chosenTimeslot"],
                            "email": FirebaseAuth.instance.currentUser!.email
                          }),
                      },
                      verificationPassed: true,
                    ),
                  ],
                )
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}: ${snapshot.stackTrace}');
            }

            return const CircularProgressIndicator(); 
          }
        )
      )
    );
  }
}