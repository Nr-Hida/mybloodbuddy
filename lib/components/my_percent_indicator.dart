import "package:flutter/material.dart";
import "package:percent_indicator/percent_indicator.dart";

class MyPercentIndicator extends StatelessWidget {
  final double percent;
  final String bloodType;
  
  const MyPercentIndicator({
    super.key,
    required this.percent,
    required this.bloodType,
  });

  Color percentToColour(double percent) {
    if (percent > .69) {
      return Colors.green;
    } else if (percent > .59) {
      return Colors.teal;
    } else if (percent > .49) {
      return Colors.yellow;
    } else {
      return Colors.red.shade900;
    }
  }

  Color percentToComplementaryColour(double percent) {
    if (percent > .69) {
      return Colors.green.shade100;
    } else if (percent > .59) {
      return Colors.teal.shade100;
    } else if (percent > .49) {
      return Colors.yellow.shade100;
    } else {
      return Colors.red.shade100;
    }
  }

  String percentToPercentage(double percent) {
    String percentage = "${(percent * 100).toInt()}%";

    return percentage;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            animation: true,
            animationDuration: 1000,
            radius: 30.0,
            percent: percent,
            progressColor: percentToColour(percent),
            backgroundColor: percentToComplementaryColour(percent),
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(percentToPercentage(percent)),
            lineWidth: 7.0,
          ),
          Text(bloodType),
        ]
      ),
    );
  }
}