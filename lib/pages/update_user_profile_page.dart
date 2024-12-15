import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:mybb/components/stringpicker.dart';
import 'package:mybb/components/my_button.dart';
import 'package:mybb/utils/enums.dart';
import 'package:mybb/utils/user.dart' as mybb_user;

final db = FirebaseFirestore.instance;

class UpdateUserProfilePage extends StatefulWidget {
  const UpdateUserProfilePage({super.key});

  @override
  State<UpdateUserProfilePage> createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UpdateUserProfilePage> {
  late Future<mybb_user.User> user;
  int _currentHeight = 160;
  int _currentWeight = 55;
  BloodType _bloodType = BloodType.undetermined;
  String _bloodTypeString = "Undetermined";
  List<String> bloodtypes = [
    "Undetermined",
    "Group A+",
    "Group A-",
    "Group B+",
    "Group B-",
    "Group AB+",
    "Group AB-",
    "Group O+",
    "Group O-",
  ];
  String currentSelection = "Undetermined";
  List<String> options = ['Apple','Kiwi', 'Tomato','Pear'];
  String currentOption = 'Apple';

  @override
  void initState() {
    super.initState();
    user = mybb_user.fetchUser();
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
    
    // Save updates to profile
    try {
      final userData = <String, dynamic>{};
      userData["height"] = _currentHeight;
      userData["weight"] = _currentWeight;
      userData["bloodType"] = convertBloodTypeToInt(_bloodType);
      userData["updatedOrNot"] = true;
      userData["updated"] = Timestamp.now();

      final docRef =  db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.update(userData);

      // Pop the loading circle
      if (context.mounted) {
        Navigator.pop(context);
      }
      // Pop the confirm dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Replace updatable user profile...
      // ...to non-updatable user profile
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushNamed(context, "user_profile");
      }
    } on FirebaseAuthException catch (e) {
      print("Something went wrong: $e");
      // Pop the loading circle
      if (context.mounted) {
        Navigator.pop(context);
      }
      // Pop the confirm dialog
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  void confirmUpdateProfileDialog() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Are you sure you want to update your profile?"),
        actions: [
          IconButton(onPressed: updateProfile, icon: const Icon(Icons.check)),
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

  void callbackString(val) {
    setState((){
      currentOption =val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          shadowColor: Colors.grey.shade200,
          elevation: 5.0,
          backgroundColor: Colors.red.shade900,
        ),
        body: FutureBuilder<mybb_user.User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
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
                            // Text(snapshot.data!.email, style: const TextStyle(
                            //   fontSize: 10.0
                            // )),
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
                          ],
                        ),
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
                  const SizedBox(height: 15.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "📝 NOTE: Please only update the following information when in consultation with your doctor / medical officer:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // snapshot.data!.bloodType.index == BloodType.undetermined.index
                  // ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15.0),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Please update your blood type:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      // Container(
                      //   decoration: const BoxDecoration(),
                      //   child: ScrollPicker(
                      //     dataArray: options,
                      //     currentSelection: currentOption,
                      //     fontSizeList: 20,
                      //     fontSizeTitle: 18,
                      //     callback: callbackString
                      //   ),
                      // ),
                      Row(
                        children: [
                          // NumberPicker(
                          //   minValue: 0,
                          //   maxValue: BloodType.values.length - 1,
                          //   value: _bloodTypeIndex,
                          //   onChanged: (value) => {
                          //     setState(() {
                          //       _bloodTypeIndex = value;
                          //       _bloodType = BloodType.values[value];
                          //       _bloodTypeString = formatBloodType(_bloodType);
                          //     })
                          //   },
                          // ),
                          // Text(formatBloodType(_bloodType)),
                          StringPicker(
                            items: bloodtypes,
                            currentSelection: _bloodTypeString,
                            onChanged: (value) => {
                              setState(() {
                                // _bloodTypeIndex = value;
                                _bloodType = BloodType.values[value];
                                _bloodTypeString = formatBloodType(_bloodType);
                              })
                            },
                          ),
                          Text(formatBloodType(_bloodType)),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     Text('${formatBloodType(_bloodType)} Group'),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Radio<BloodType>(
                      //           activeColor: Colors.red.shade900,
                      //           value: BloodType.groupAplus,
                      //           groupValue: _bloodType,
                      //           onChanged: (BloodType? value) {
                      //             setState(() {
                      //               _bloodType = value as BloodType;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Group A+"),
                      //         Radio<BloodType>(
                      //           activeColor: Colors.red.shade900,
                      //           value: BloodType.groupAminus,
                      //           groupValue: _bloodType,
                      //           onChanged: (BloodType? value) {
                      //             setState(() {
                      //               _bloodType = value as BloodType;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Group A-"),
                      //       ],
                      //     ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Radio<BloodType>(
                      //           activeColor: Colors.red.shade900,
                      //           value: BloodType.groupBplus,
                      //           groupValue: _bloodType,
                      //           onChanged: (BloodType? value) {
                      //             setState(() {
                      //               _bloodType = value as BloodType;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Group B+"),
                      //         Radio<BloodType>(
                      //           activeColor: Colors.red.shade900,
                      //           value: BloodType.groupBminus,
                      //           groupValue: _bloodType,
                      //           onChanged: (BloodType? value) {
                      //             setState(() {
                      //               _bloodType = value as BloodType;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Group B-"),
                      //       ],
                      //     ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Radio<BloodType>(
                      //           activeColor: Colors.red.shade900,
                      //           value: BloodType.groupABplus,
                      //           groupValue: _bloodType,
                      //           onChanged: (BloodType? value) {
                      //             setState(() {
                      //               _bloodType = value as BloodType;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Group AB+"),
                      //         Radio<BloodType>(
                      //           activeColor: Colors.red.shade900,
                      //           value: BloodType.groupABminus,
                      //           groupValue: _bloodType,
                      //           onChanged: (BloodType? value) {
                      //             setState(() {
                      //               _bloodType = value as BloodType;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Group AB-"),
                      //       ],
                      //     ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Radio<BloodType>(
                      //           activeColor: Colors.red.shade900,
                      //           value: BloodType.groupOplus,
                      //           groupValue: _bloodType,
                      //           onChanged: (BloodType? value) {
                      //             setState(() {
                      //               _bloodType = value as BloodType;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Group O+"),
                      //         Radio<BloodType>(
                      //           activeColor: Colors.red.shade900,
                      //           value: BloodType.groupOminus,
                      //           groupValue: _bloodType,
                      //           onChanged: (BloodType? value) {
                      //             setState(() {
                      //               _bloodType = value as BloodType;
                      //             });
                      //           },
                      //         ),
                      //         const Text("Group O-"),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  // :
                  // const Column(
                  //   children: [],
                  // ),
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker(
                        value: _currentHeight,
                        minValue: 0,
                        maxValue: 300,
                        onChanged: (value) => setState(() => _currentHeight = value),
                      ),
                      Text('${_currentHeight}cm'),
                    ],
                  ),
                  const SizedBox(height: 15.0),
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
                  MyButton(
                    text: "Update",
                    onTap: confirmUpdateProfileDialog,
                    verificationPassed: _bloodType.index != BloodType.undetermined.index,
                  ),
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
      )
    );
  }
}