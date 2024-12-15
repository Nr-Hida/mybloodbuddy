import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mybb/utils/enums.dart';
// import 'package:mybb/utils/user.dart' as mybb_user;
import "package:mybb/utils/appointment.dart";

class AdminCheckUserProfilePage extends StatelessWidget {
  const AdminCheckUserProfilePage({super.key});

  String formatLastDonationDate(String lastDonationDate) {
    String result;
    
    // HACK: The year UNIX epoch is treated as a sign a donor never donated blood
    final splitted = lastDonationDate.split("/");
    if (splitted[splitted.length - 1] == "1970") {
      result = "Never donated";
    } else {
      return lastDonationDate;
    }
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Donor Detail", style: TextStyle(
            color: Colors.white
          )),
          shadowColor: Colors.grey.shade200,
          elevation: 5.0,
          backgroundColor: Colors.red.shade900,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 10.0),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          arguments["fullName"],
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
                          arguments["email"],
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
                          arguments["phone"],
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
                          arguments["address"],
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
                          arguments["ic"],
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          arguments["bloodType"],
                          style: const TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(arguments["profilePicture"]),
                      // Text(arguments["email"], style: const TextStyle(
                      //   fontSize: 10.0
                      // )),
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
                  Text('${arguments["height"]}cm', style: const TextStyle(
                    decoration: TextDecoration.underline,
                  )),
                  const SizedBox(width: 15.0),
                  const Text(
                    "Weight: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('${arguments["weight"]}kg', style: const TextStyle(
                    decoration: TextDecoration.underline,
                  )),
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
                    arguments["gender"],
                    style: const TextStyle(
                      decoration: TextDecoration.underline
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  const Text(
                    // "Age (auto-calculated from Date of Birth)",
                    "Age: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "${DateTime.now().year - arguments["dob"].toDate().year} years old",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Race: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    arguments["race"],
                    style: const TextStyle(
                      decoration: TextDecoration.underline
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  const Text(
                    "Marriage Status: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    arguments["marriageStatus"],
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
                    "${arguments["dob"].toDate().day.toString()} ${getMonthName(arguments["dob"].toDate().month)} ${arguments["dob"].toDate().year.toString()} (${arguments["dob"].toDate().day.toString()}/${arguments["dob"].toDate().month.toString()}/${arguments["dob"].toDate().year.toString()})", style: const TextStyle(
                      decoration: TextDecoration.underline,
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Last Donation Date:  ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900
                  ),
                ),
                Text(
                  formatLastDonationDate(arguments["lastDonated"]),
                  style: TextStyle(
                    // decoration: TextDecoration.underline,
                    backgroundColor: Colors.red.shade900,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}