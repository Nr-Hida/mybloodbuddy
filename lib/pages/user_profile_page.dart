import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybb/utils/enums.dart';
import 'package:mybb/utils/user.dart' as mybb_user;

final db = FirebaseFirestore.instance;

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<mybb_user.User>? user;

  @override
  void initState() {
    super.initState();
    user = mybb_user.fetchUser();
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
        appBar: AppBar(
          title: const Text("Profile", style: TextStyle(
            color: Colors.white
          )),
          shadowColor: Colors.grey.shade200,
          elevation: 5.0,
          backgroundColor: Color(0xFFBC3B3B),
        ),
        body: FutureBuilder<mybb_user.User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.only(top: 10.0),
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Full Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data!.fullName,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              const Text(
                                "Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data!.email,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              const Text(
                                "Phone number",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data!.phone,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              const Text(
                                "Address",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data!.address,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              const Text(
                                "IC No.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data!.ic,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                formatBloodType(snapshot.data!.bloodType),
                                style: const TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 5
                                )
                              ),
                              child: const Icon(Icons.person, size: 100.0),
                            ),
                            Text(snapshot.data!.profilePicture),
                            Text(snapshot.data!.email, style: const TextStyle(
                              fontSize: 10.0
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          "Height: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${snapshot.data!.height}cm', style: const TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                        const SizedBox(width: 15.0),
                        const Text(
                          "Weight: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('${snapshot.data!.weight}kg', style: const TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Date of Birth",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "${snapshot.data!.dob.toDate().day.toString()}/${snapshot.data!.dob.toDate().month.toString()}/${snapshot.data!.dob.toDate().year.toString()} (${snapshot.data!.dob.toDate().day.toString()} ${_getMonthName(snapshot.data!.dob.toDate().month)} ${snapshot.data!.dob.toDate().year.toString()})", style: const TextStyle(
                            decoration: TextDecoration.underline,
                          )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Age",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "${DateTime.now().year - snapshot.data!.dob.toDate().year} years old",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          "Gender: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          formatGender(snapshot.data!.gender),
                          style: const TextStyle(
                            decoration: TextDecoration.underline
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          "Race: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          formatRace(snapshot.data!.race),
                          style: const TextStyle(
                            decoration: TextDecoration.underline
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          "Marriage Status: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          formatMarriageStatus(snapshot.data!.marriageStatus),
                          style: const TextStyle(
                            decoration: TextDecoration.underline
                          ),
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(height: 15.0),
                ],
              );
            } else if (snapshot.hasError) {
              // Navigator.pop(context);
              // return const UpdateUserProfilePage();
              return Text('${snapshot.error}: ${snapshot.stackTrace}');
            }
            
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          }
        ),
      )
    );
  }
}