import "package:flutter/material.dart";

class MyTable extends StatelessWidget {
  const MyTable({super.key});
  
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
        const TableRow(
          children: [
            Column(
              children: [
                Text("Blood Type", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
            Column(
              children: [
                Text("O+", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
        const TableRow(
          children: [
            Column(
              children: [
                Text("ID Number", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
            Column(
              children: [
                Text("123456-78-9012", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
        const TableRow(
          children: [
            Column(
              children: [
                Text("No. of Donations", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
            Column(
              children: [
                Text("0", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
        const TableRow(
          children: [
            Column(
              children: [
                Text("Weight (kg)", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
            Column(
              children: [
                Text("65", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
          ]
        ),
        const TableRow(
          children: [
            Column(
              children: [
                Text("Height (cm)", style: TextStyle(
                  color: Colors.white
                ))
              ],
            ),
            Column(
              children: [
                Text("177", style: TextStyle(
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