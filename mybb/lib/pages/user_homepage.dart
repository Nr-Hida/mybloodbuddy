import 'package:flutter/material.dart';
import 'package:mybb/components/my_appointment.dart';
import 'package:mybb/components/blood_donor_card.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAppointment(),
          BloodDonorCard(),
        ]
      ),
    ));
  }
}