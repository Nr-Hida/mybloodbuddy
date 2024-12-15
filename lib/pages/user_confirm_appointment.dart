import "package:flutter/material.dart";
import "package:mybb/components/my_button.dart";

class UserConfirmAppointment extends StatelessWidget {
  const UserConfirmAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    
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
              onTap: () => {
                Navigator.pushNamedAndRemoveUntil(context, "user_home", (Route<dynamic> route) => false)
              },
              verificationPassed: true,
            ),
          ],
        ),
      ),
    );
  }
}