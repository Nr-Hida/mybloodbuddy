import "package:flutter/material.dart";
import "package:mybb/components/my_table.dart";

class BloodDonorCard extends StatelessWidget {
  const BloodDonorCard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
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
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: MyTable()
        ),
      ),
    );
  }
}