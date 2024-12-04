import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:mybb/components/my_button.dart';

final db = FirebaseFirestore.instance;

class User {
  final String fullName;
  final String email;
  final String address;
  final BloodType bloodType;
  final Timestamp dob;
  final Gender gender;
  final double height;
  final double weight;
  final String ic;
  final MarriageStatus marriageStatus;
  final String phone;
  final String profilePicture;
  final Race race;

  User({
    required this.fullName,
    required this.email,
    required this.address,
    required this.bloodType,
    required this.dob,
    required this.gender,
    required this.height,
    required this.weight,
    required this.ic,
    required this.marriageStatus,
    required this.phone,
    required this.profilePicture,
    required this.race,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'email': String email,
        'full_name': String fullName,
        'dob': Timestamp dob,
        'address': String address,
        'blood_type': BloodType bloodType,
        'gender': Gender gender,
        'height': double height,
        'weight': double weight,
        'ic': String ic,
        'marriage_status': MarriageStatus marriageStatus,
        'phone': String phone,
        'profile_picture': String profilePicture,
        'race': Race race
      } =>
        User(
          email: email.toString(),
          fullName: fullName.toString(),
          dob: dob,
          address: address.toString(),
          bloodType: bloodType,
          gender: gender,
          height: height,
          weight: weight,
          ic: ic,
          marriageStatus: marriageStatus,
          phone: phone,
          profilePicture: profilePicture,
          race: race
        ),
      FormatException fe => throw FormatException('Failed to load user: $fe'),
      Exception e => throw Exception("Exception thrown: $e"),
      // _ => throw Exception("Not any kind of known Exception. Please report this error and we'll compensate you monetarily for your time."),
      _ => throw Exception("Not any kind of known Exception.\nPlease report this error."),
    };
  }
}

Future<User> fetchUser() async {
  Map<String, dynamic> finalData = {};
  final docRef = db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
  await docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      finalData = data;
      return User(
        email: data["email"] ?? "",
        fullName: data["full_name"] ?? "",
        dob: data["dob"] ?? Timestamp(0, 0),
        address: data["address"] ?? "",
        bloodType: BloodType.values[data["bloodType"] ?? 0] ?? BloodType.groupA,
        gender: Gender.values[data["gender"] ?? 0] ?? Gender.male,
        height: double.parse(data["height"].toString()) ?? 150,
        weight: double.parse(data["weight"].toString()) ?? 50,
        ic: data["ic"] ?? "",
        marriageStatus: MarriageStatus.values[data["marriageStatus"] ?? 0] ?? MarriageStatus.neverMarried,
        phone: data["phone"] ?? "",
        profilePicture: data["profilePicture"] ?? "",
        race: Race.values[data["race"]] ?? Race.malay
      );
    },
    onError: (e) => {
      throw Exception("Failed to fetch user: $e")
    },
  );

  return User(
    email: finalData["email"] != "" ? finalData["email"] : "",
    fullName: finalData["full_name"] != "" ? finalData["full_name"] : "",
    dob: finalData["dob"] != "" ? finalData["dob"] : Timestamp(0, 0),
    address: finalData["address"] != "" ? finalData["address"] : "",
    bloodType: BloodType.values[finalData["bloodType"] ?? 0] ?? BloodType.groupA,
    gender: Gender.values[finalData["gender"] ?? 0] ?? Gender.male,
    height: double.parse(finalData["height"].toString()) ?? 150,
    weight: double.parse(finalData["weight"].toString()) ?? 50,
    ic: finalData["ic"] != "" ? finalData["ic"] : "",
    marriageStatus: MarriageStatus.values[finalData["marriageStatus"] ?? 0] ?? MarriageStatus.neverMarried,
    phone: finalData["phone"] != "" ? finalData["phone"] : "",
    profilePicture: finalData["profilePicture"] ?? "",
    race: Race.values[finalData["race"] ?? 0] ?? Race.malay
  );
}

enum Gender { male, female }
enum Race { malay, chinese, indian, iban, kadazan, melanau, murut, bidayuh, bajau }
enum MarriageStatus { neverMarried, married, divorcedOrSeparated }
enum BloodType { undetermined, groupA, groupB, groupAB, groupO }

String formatGender(Gender g) {
  if (g == Gender.male) {
    return "Male";
  } else {
    return "Female";
  }
}

String formatRace(Race r) {
  if (r == Race.malay) {
    return "Malay";
  } else if (r == Race.chinese) {
    return "Chinese";
  } else if (r == Race.indian) {
    return "Indian";
  } else if (r == Race.iban) {
    return "Iban";
  } else if (r == Race.kadazan) {
    return "Kadazan";
  } else if (r == Race.melanau) {
    return "Melanau";
  } else if (r == Race.murut) {
    return "Murut";
  } else if (r == Race.bidayuh) {
    return "Bidayuh";
  } else {
    return "Bajau";
  }
}

String formatMarriageStatus(MarriageStatus group) {
  if (group == MarriageStatus.neverMarried) {
    return "Never Married";
  } else if (group == MarriageStatus.married) {
    return "Married";
  } else { // group == MarriageStatus.divorcedOrSeparated
    return "Divorced or Separated";
  }
}

String formatBloodType(BloodType group) {
  if (group == BloodType.groupA) {
    return "Group A";
  } else if (group == BloodType.groupB) {
    return "Group B";
  } else if (group == BloodType.groupAB) {
    return "Group AB";
  } else if (group == BloodType.groupO) {
    return "Group O";
  } else {
    return "Unknown";
  }
}

class UpdateUserProfilePage extends StatefulWidget {
  const UpdateUserProfilePage({super.key});

  @override
  State<UpdateUserProfilePage> createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UpdateUserProfilePage> {
  late Future<User> user;
  int _currentHeight = 150;
  int _currentWeight = 50;
  final String _onRecordDOB = DateTime.now().toString();
  DateTime _currentDOB = DateTime.now();
  int _calculatedAge = DateTime.now().year - 2004;
  Gender? _gender = Gender.male;
  Race? _race = Race.malay;
  MarriageStatus? _marriageStatus = MarriageStatus.neverMarried;

  @override
  void initState() {
    super.initState();
    user = fetchUser();
  }
  
  void updateProfile()
  async {
    // show loading
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
    
    // try sign in
    try {
      // TODO: save updates to profile

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) { // TODO: change this line to something relevant
      print("something went wrong: $e");
      // pop the loading circle
      Navigator.pop(context);
      
      // TODO: catch errors
      // if (e.code == "user-not-found") {
      //   userNotFoundMessage();
      // } else if (e.code == "wrong-password") {
      //   incorrectPasswordMessage();
      // }
    }
  }

  // show date picker method
  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
    ).then((value) {
      setState(() {
        _currentDOB = value!;
        _calculatedAge = DateTime.now().year - _currentDOB.year;
      });
    });
  }

  void confirmUpdateProfile() {}

  void confirmUpdateProfileDialog() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Are you sure you want to update your profile?"),
        actions: [
          IconButton(onPressed: confirmUpdateProfile, icon: const Icon(Icons.check)),
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ],
      );
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
        appBar: AppBar(
          title: const Text("Profile"),
          shadowColor: Colors.grey.shade200,
          elevation: 5.0,
        ),
        body: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
        // body: ListView(
                padding: const EdgeInsets.only(top: 15.0),
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
                                // "Muhd Aiman Bin Azhar",
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
                                // "muhdazhar02@gmail.com",
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
                                // "+6012-2022687",
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
                                // "Mana-mana je lah",
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              // Text(
                              //   "Setia, 53100, Kuala Lumpur",
                              //   style: TextStyle(
                              //     decoration: TextDecoration.underline,
                              //   ),
                              // ),
                              const SizedBox(height: 15.0),
                              const Text(
                                "IC No.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data!.ic,
                                // "020107-14-XXXX",
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
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                // formatBloodType(snapshot.data!.bloodType),
                                formatBloodType(BloodType.undetermined),
                                style: const TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Please update your height:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Text(
                      //   "Height",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold
                      //   ),
                      // ),
                      NumberPicker(
                        value: _currentHeight,
                        minValue: 0,
                        maxValue: 300,
                        onChanged: (value) => setState(() => _currentHeight = value),
                      ),
                      Text('${_currentHeight}cm'),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Please update your weight:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Text(
                      //   "Weight",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold
                      //   ),
                      // ),
                      Text('${_currentWeight}kg'),
                      NumberPicker(
                        axis: Axis.horizontal,
                        value: _currentWeight,
                        minValue: 0,
                        maxValue: 300,
                        onChanged: (value) => setState(() => _currentWeight = value),
                      ),
                    ],
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
                          "Age (auto-calculated from Date of Birth)",
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
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         "Date of Birth",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold
                  //         ),
                  //       ),
                  //       _onRecordDOB == _currentDOB.toString()
                  //       ?
                  //       Text("On record: ${_currentDOB.day.toString()}/${_currentDOB.month.toString()}/${_currentDOB.year.toString()} (${_currentDOB.day.toString()} ${_getMonthName(_currentDOB.month)} ${_currentDOB.year.toString()})")
                  //       :
                  //       Text("Updated DOB: ${_currentDOB.day.toString()}/${_currentDOB.month.toString()}/${_currentDOB.year.toString()} (${_currentDOB.day.toString()} ${_getMonthName(_currentDOB.month)} ${_currentDOB.year.toString()})"),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(vertical: 15.0),
                  //     decoration: BoxDecoration(
                  //       color: Colors.red.shade900,
                  //       borderRadius: BorderRadius.circular(15.0)
                  //     ),
                  //     child: ListTile(
                  //       title: const Text("Update your date of birth"),
                  //       leading: const Icon(Icons.calendar_month),
                  //       onTap: _showDatePicker,
                  //       iconColor: Colors.white,
                  //       textColor: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 15.0),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         "Age (auto-calculated from Date of Birth)",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold
                  //         ),
                  //       ),
                  //       Text("${_calculatedAge.toString()} years old"),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 15.0),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0),
                  //   child: Row(
                  //     children: [
                  //       const Text(
                  //         "Gender",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold
                  //         ),
                  //       ),
                  //       Radio<Gender>(
                  //         value: Gender.male,
                  //         groupValue: _gender,
                  //         onChanged: (Gender? value) {
                  //           setState(() {
                  //             _gender = value;
                  //           });
                  //         },
                  //       ),
                  //       const Text("Male"),
                  //       Radio<Gender>(
                  //         value: Gender.female,
                  //         groupValue: _gender,
                  //         onChanged: (Gender? value) {
                  //           setState(() {
                  //             _gender = value;
                  //           });
                  //         },
                  //       ),
                  //       const Text("Female"),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 15.0),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0),
                  //   child: Row(
                  //     children: [
                  //       const Text(
                  //         "Race",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold
                  //         ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.malay,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Malay"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.iban,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Iban"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.murut,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Murut"),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.chinese,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Chinese"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.kadazan,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Kadazan"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.bidayuh,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Bidayuh"),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.indian,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Indian"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.melanau,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Melanau"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: Race.bajau,
                  //                 groupValue: _race,
                  //                 onChanged: (Race? value) {
                  //                   setState(() {
                  //                     _race = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Bajau"),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 15.0),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0),
                  //   child: Row(
                  //     children: [
                  //       const Text(
                  //         "Marriage Status",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold
                  //         ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Radio<MarriageStatus>(
                  //                 value: MarriageStatus.neverMarried,
                  //                 groupValue: _marriageStatus,
                  //                 onChanged: (MarriageStatus? value) {
                  //                   setState(() {
                  //                     _marriageStatus = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Never married"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Radio<MarriageStatus>(
                  //                 value: MarriageStatus.married,
                  //                 groupValue: _marriageStatus,
                  //                 onChanged: (MarriageStatus? value) {
                  //                   setState(() {
                  //                     _marriageStatus = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Married"),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Radio<MarriageStatus>(
                  //                 value: MarriageStatus.divorcedOrSeparated,
                  //                 groupValue: _marriageStatus,
                  //                 onChanged: (MarriageStatus? value) {
                  //                   setState(() {
                  //                     _marriageStatus = value;
                  //                   });
                  //                 }
                  //               ),
                  //               const Text("Divorced/Separated"),
                  //             ]
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 15.0),
                  MyButton(text: "Update", onTap: confirmUpdateProfileDialog),
                  const SizedBox(height: 15.0),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}: ${snapshot.stackTrace}');
            }
            
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          }
        ),
        // )
      )
    );
  }
}