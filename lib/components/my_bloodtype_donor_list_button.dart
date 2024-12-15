import "package:flutter/material.dart";

class MyBloodTypeDonorListBtn extends StatelessWidget {
  final String text;
  final Function()? onTap;
  
  const MyBloodTypeDonorListBtn({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(3.0),
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0.0, 2.0),
              blurRadius: 1.0,
              spreadRadius: 1.0
            )
          ],
        ),
        child: Center(
          child: Text(text, style: TextStyle(
            color: Colors.red.shade100,
            fontSize: 55.0,
            fontWeight: FontWeight.w900,
          )),
        ),
      ),
    );
  }
}