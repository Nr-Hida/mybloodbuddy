import 'package:flutter/material.dart';

class MyBloodBuddyLogo extends StatelessWidget {
  final String imageFilename;
  final bool includeTitle;
  
  const MyBloodBuddyLogo({
    super.key,
    required this.imageFilename,
    required this.includeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "lib/images/$imageFilename",
            width: 50.0,
            height: 50.0,
          ),
          includeTitle
          ?
          const Text(
            "MyBloodBuddy",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold
            ),
          )
          :
          const Text(""),
        ],
      ),
    );
  }
}