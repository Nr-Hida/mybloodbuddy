import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:mybb/components/my_button.dart";

class UserConfirmAppointment extends StatelessWidget {
  const UserConfirmAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    void confirmAppointment() {
      try {
        final userData = <String, dynamic>{};
        userData["lastDonated"] = Timestamp.fromDate(arguments["chosenDateTime"]);

        final docRef =  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
        docRef.update(userData);
        Navigator.pushNamedAndRemoveUntil(context, "user_home", (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        print("Something went wrong when updating lastDonated: $e");
        // Pop the loading circle
        if (context.mounted) {
          Navigator.pop(context);
        }
        // Pop the confirm dialog
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    };
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 70.0,
            ),
            const SizedBox(height: 20.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Your appointment has been confirmed\non ",
                    style: TextStyle(
                      color: Colors.black,
                    )
                  ),
                  TextSpan(
                    text: "${arguments["chosenDateTimeString"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(
                    text: " at ",
                    style: TextStyle(
                      color: Colors.black,
                    )
                  ),
                  TextSpan(
                    text: "${arguments["chosenTimeslot"]}.",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ]
              )
            ),
            // Text(
            //   "Your appointment has been confirmed on ${arguments["chosenDateTimeString"]} at ${arguments["chosenTimeslot"]}.",
            //   textAlign: TextAlign.center,
            // ),
            const Text("Kindly reach on time.", textAlign: TextAlign.center),
            const SizedBox(height: 20.0),
            MyButton(
              text: "Done",
              onTap: confirmAppointment,
              verificationPassed: true,
            ),
          ],
        ),
      ),
    );
  }
}