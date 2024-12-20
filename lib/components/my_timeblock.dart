import 'package:flutter/material.dart';

class MyTimeblock extends StatelessWidget {
  final String text;
  final Function()? onTap;
  bool selected = false;
  
  MyTimeblock({
    super.key,
    required this.text,
    required this.onTap,
    required this.selected
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selected ? Color(0xFFBC3B3B) : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black
          ),
        ),
      ),
    );
  }
}