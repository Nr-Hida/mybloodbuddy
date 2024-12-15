import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool verificationPassed;
  
  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.verificationPassed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: verificationPassed ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: verificationPassed ? Colors.red.shade900 : Colors.grey,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              // fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}