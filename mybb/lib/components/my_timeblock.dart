import 'package:flutter/material.dart';

class MyTimeblock extends StatelessWidget {
  final String text;
  final Function()? onTap;
  
  const MyTimeblock({
    super.key,
    required this.text,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}