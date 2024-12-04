import 'package:flutter/material.dart';
import 'package:mybb/components/goto_profile_button.dart';

class BloodTypeDonorCard extends StatelessWidget{
  final String fullName;
  final String bloodType;
  final String ic;
  final String phone;
  final String lastDonated;
  
  const BloodTypeDonorCard({
    super.key,
    required this.fullName,
    required this.bloodType,
    required this.ic,
    required this.phone,
    required this.lastDonated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
            spreadRadius: 1.0
          )
        ]
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Name: $fullName"),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        bloodType,
                        style: const TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("IC Number: $ic"),
          ),
          const SizedBox(height: 10.0,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Phone Number: $phone"),
          ),
          const SizedBox(height: 10.0,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Last Donate: $lastDonated"),
          ),
          const SizedBox(height: 10.0),
          GotoProfileButton(text: "Check profile", onTap: () {
            Navigator.pushNamed(context, "user_profile", arguments: {});
          })
        ],
      ),
    );
  }
}