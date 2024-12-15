import 'package:flutter/material.dart';
import 'package:mybb/components/my_appointment.dart';
import 'package:mybb/components/blood_donor_card.dart';
import 'package:mybb/utils/appointment.dart';

class UserHomepage extends StatelessWidget {
  final String fullName;
  final String bloodType;
  final String icNumber;
  final int donationCount;
  final double weight;
  final double height;
  final Future<Appointment> upcomingApp;
  
  const UserHomepage({
    super.key,
    required this.fullName,
    required this.bloodType,
    required this.icNumber,
    required this.donationCount,
    required this.weight,
    required this.height,
    required this.upcomingApp,
  });
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0),
              child: ListTile(
                title: Text(
                  "Hi, $fullName",
                  style: const TextStyle(
                    fontWeight: FontWeight.w900
                  )
                ),
                leading: const Icon(Icons.person),
              ),
            ),
            MyAppointment(
              upcomingApp: upcomingApp
            ),
            BloodDonorCard(
              bloodType: bloodType,
              icNumber: icNumber,
              donationCount: donationCount,
              weight: weight,
              height: height,
            ),
          ]
        ),
      )
    );
  }
}