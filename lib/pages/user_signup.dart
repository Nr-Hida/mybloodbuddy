import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybb/components/my_button.dart';
import 'package:mybb/utils/enums.dart';
import 'package:mybb/utils/appointment.dart';

final db = FirebaseFirestore.instance;

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UserSignup> {
  final String _onRecordDOB = DateTime.now().toString();
  DateTime _currentDOB = DateTime.now();
  int _calculatedAge = DateTime.now().year - DateTime.now().year;
  Gender _gender = Gender.male;
  Race _race = Race.malay;
  MarriageStatus _marriageStatus = MarriageStatus.single;
  
  // text editing controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final icController = TextEditingController();

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

  void saveUser() {
    final userData = <String, dynamic>{};
    userData["email"] = emailController.text;
    userData["fullName"] = fullNameController.text;
    userData["dob"] = Timestamp.fromDate(_currentDOB);
    userData["address"] = addressController.text;
    userData["bloodType"] = 0;
    userData["gender"] = convertGenderToInt(_gender);
    userData["updatedOrNot"] = false;
    userData["height"] = 0;
    userData["weight"] = 0;
    userData["ic"] = icController.text;
    userData["marriageStatus"] = convertMarriageStatusToInt(_marriageStatus);
    userData["phone"] = contactController.text;
    userData["profilePicture"] = "";
    userData["race"] = convertRaceToInt(_race);
    userData["created"] = Timestamp.now();
    userData["updated"] = Timestamp.now();
    userData["lastDonated"] = Timestamp(0,0);
    
    final docRef = db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.set(userData).onError((e, _) => print("Error writing document: $e"));
  }

  void signUserUp()
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
    
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );

      // Pop the loading circle, if mounted
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Save user data into database
      saveUser();
      
      // Check authStateChanges (in user_auth_page) to change screen
      if (context.mounted) {
        Navigator.pop(context);
      }
      Navigator.pushNamed(context, "user_auth_page");
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle, if mounted
      if (context.mounted) {
        Navigator.pop(context);
      }
      
      if (e.code == 'weak-password') {
        weakPasswordMessage();
      } else if (e.code == 'email-already-in-use') {
        userAlreadyExistsMessage();
      }
    } catch (e) {
      print(e);
    }
  }

  void userAlreadyExistsMessage() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(title: Text("User Already Exists"));
    });
  }

  void weakPasswordMessage() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(title: Text("Weak Password"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Sign Up"),
        //   shadowColor: Colors.grey.shade200,
        //   elevation: 5.0,
        // ),
        body: ListView(
          padding: const EdgeInsets.only(top: 15.0),
          children: [
            ListTile(
              title: const Text("Create Account", style: TextStyle(
                fontSize: 20.0,
              )),
              subtitle: Row(
                children: [
                  const Text("Already a member?"),
                  const SizedBox(width: 4.0,),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                      Navigator.pushNamed(context, "user_auth_page")
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.blue
                      )
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Full Name as per IC',
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email address',
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: contactController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contact Number',
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address',
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: icController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'IC No.',
                ),
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
                  _onRecordDOB == _currentDOB.toString()
                  ?
                  const Text("Date of Birth have not been selected")
                  :
                  Text("Selected DOB: ${_currentDOB.day.toString()}/${_currentDOB.month.toString()}/${_currentDOB.year.toString()} (${_currentDOB.day.toString()} ${getMonthName(_currentDOB.month)} ${_currentDOB.year.toString()})"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFBC3B3B),
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: ListTile(
                  title: const Text("Select your date of birth"),
                  leading: const Icon(Icons.calendar_month),
                  onTap: _showDatePicker,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                ),
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
                  Text("${_calculatedAge.toString()} years old"),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    "Gender:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Radio<Gender>(
                    activeColor: Color(0xFFBC3B3B),
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gender = value as Gender;
                      });
                    },
                  ),
                  const Text("Male"),
                  const SizedBox(width: 7.0),
                  Radio<Gender>(
                    activeColor: Color(0xFFBC3B3B),
                    value: Gender.female,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gender = value as Gender;
                      });
                    },
                  ),
                  const Text("Female"),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Column(
                    children: [
                      Text(
                        "Race:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 47.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: Color(0xFFBC3B3B),
                                value: Race.malay,
                                groupValue: _race,
                                onChanged: (Race? value) {
                                  setState(() {
                                    _race = value as Race;
                                  });
                                }
                              ),
                              const Text("Malay"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: Color(0xFFBC3B3B),
                                value: Race.chinese,
                                groupValue: _race,
                                onChanged: (Race? value) {
                                  setState(() {
                                    _race = value as Race;
                                  });
                                }
                              ),
                              const Text("Chinese"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: Color(0xFFBC3B3B),
                                value: Race.iban,
                                groupValue: _race,
                                onChanged: (Race? value) {
                                  setState(() {
                                    _race = value as Race;
                                  });
                                }
                              ),
                              const Text("Iban"),
                            ],
                          ),
                          const SizedBox(width: 10.0),
                          Row(
                            children: [
                              Radio(
                                activeColor: Color(0xFFBC3B3B),
                                value: Race.kadazan,
                                groupValue: _race,
                                onChanged: (Race? value) {
                                  setState(() {
                                    _race = value as Race;
                                  });
                                }
                              ),
                              const Text("Kadazan"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: Color(0xFFBC3B3B),
                                value: Race.murut,
                                groupValue: _race,
                                onChanged: (Race? value) {
                                  setState(() {
                                    _race = value as Race;
                                  });
                                }
                              ),
                              const Text("Murut"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: Color(0xFFBC3B3B),
                                value: Race.bidayuh,
                                groupValue: _race,
                                onChanged: (Race? value) {
                                  setState(() {
                                    _race = value as Race;
                                  });
                                }
                              ),
                              const Text("Bidayuh"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: Color(0xFFBC3B3B),
                                value: Race.indian,
                                groupValue: _race,
                                onChanged: (Race? value) {
                                  setState(() {
                                    _race = value as Race;
                                  });
                                }
                              ),
                              const Text("Indian"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: Color(0xFFBC3B3B),
                                value: Race.bajau,
                                groupValue: _race,
                                onChanged: (Race? value) {
                                  setState(() {
                                    _race = value as Race;
                                  });
                                }
                              ),
                              const Text("Bajau"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color(0xFFBC3B3B),
                            value: Race.melanau,
                            groupValue: _race,
                            onChanged: (Race? value) {
                              setState(() {
                                _race = value as Race;
                              });
                            }
                          ),
                          const Text("Melanau"),
                        ],
                      ),
                    ],
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [],
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [],
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    "Marriage\nStatus:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 23.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<MarriageStatus>(
                            activeColor: Color(0xFFBC3B3B),
                            value: MarriageStatus.single,
                            groupValue: _marriageStatus,
                            onChanged: (MarriageStatus? value) {
                              setState(() {
                                _marriageStatus = value as MarriageStatus;
                              });
                            }
                          ),
                          const Text("Single"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<MarriageStatus>(
                            activeColor: Color(0xFFBC3B3B),
                            value: MarriageStatus.married,
                            groupValue: _marriageStatus,
                            onChanged: (MarriageStatus? value) {
                              setState(() {
                                _marriageStatus = value as MarriageStatus;
                              });
                            }
                          ),
                          const Text("Married"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<MarriageStatus>(
                            activeColor: Color(0xFFBC3B3B),
                            value: MarriageStatus.divorcedOrSeparated,
                            groupValue: _marriageStatus,
                            onChanged: (MarriageStatus? value) {
                              setState(() {
                                _marriageStatus = value as MarriageStatus;
                              });
                            }
                          ),
                          const Text("Divorced/Separated"),
                        ]
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // log in as admin button
            MyButton(
              text: "Sign up",
              onTap: signUserUp,
              verificationPassed: emailController.text != ""
              && passwordController.text != ""
              && confirmPasswordController.text != ""
              && passwordController.text == confirmPasswordController.text
              && fullNameController.text != ""
              && contactController.text != ""
              && addressController.text != ""
              && icController.text != ""
              && "${_currentDOB.day}/${_currentDOB.month}/${_currentDOB.year}" != "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            ),
            const SizedBox(height: 15),
          ],
        )
      )
    );
  }
}