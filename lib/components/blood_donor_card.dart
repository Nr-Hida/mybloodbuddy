import "package:flutter/material.dart";
import "package:mybb/components/my_table.dart";

class BloodDonorCard extends StatelessWidget {
  final bloodType;
  final icNumber;
  final donationCount;
  final weight;
  final height;
  
  const BloodDonorCard({
    super.key,
    required this.bloodType,
    required this.icNumber,
    required this.donationCount,
    required this.weight,
    required this.height,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(4.0, 4.0),
              blurRadius: 5.0,
              spreadRadius: 1.0
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0, left: 10.0, top: 10.0, right: 10.0),
          child: MyTable(
            bloodType: bloodType,
            icNumber: icNumber,
            donationCount: donationCount,
            weight: weight,
            height: height,
          )
        ),
      ),
    );
  }
}