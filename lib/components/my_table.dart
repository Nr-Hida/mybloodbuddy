import "package:flutter/material.dart";

class MyTable extends StatelessWidget {
  final bloodType;
  final icNumber;
  final donationCount;
  final weight;
  final height;
  
  const MyTable({
    super.key,
    required this.bloodType,
    required this.icNumber,
    required this.donationCount,
    required this.weight,
    required this.height,
  });
  
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Blood Donor Card"),
                    ),
                  ),
                ),
              ],
            ),
            const Column(),
          ]
        ),
        TableRow(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0),
                  child: Text("Blood Type", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bloodType, style: const TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
        TableRow(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0),
                  child: Text("IC Number", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(icNumber, style: const TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
        TableRow(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0),
                  child: Text("No. of Donations", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(donationCount.toString(), style: const TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
        TableRow(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0),
                  child: Text("Weight (kg)", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weight.toString(), style: const TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
        TableRow(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0),
                  child: Text("Height (cm)", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(height.toString(), style: const TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
      ],
    );
  }
}