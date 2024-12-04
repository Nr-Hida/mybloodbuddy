import 'package:flutter/material.dart';
import 'package:mybb/components/my_percent_indicator.dart';

class BloodStockInventory extends StatelessWidget {
  const BloodStockInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Text("BLOOD STOCK INVENTORY"),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.red.shade900,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  spreadRadius: 1.0
                )
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPercentIndicator(
                      percent: 0.7,
                      bloodType: "A+",
                    ),
                    MyPercentIndicator(
                      percent: 0.64,
                      bloodType: "A-",
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPercentIndicator(
                      percent: 0.9,
                      bloodType: "B+",
                    ),
                    MyPercentIndicator(
                      percent: 0.82,
                      bloodType: "B-",
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPercentIndicator(
                      percent: 0.4,
                      bloodType: "AB+",
                    ),
                    MyPercentIndicator(
                      percent: 0.5,
                      bloodType: "AB-",
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPercentIndicator(
                      percent: 0.6,
                      bloodType: "O+",
                    ),
                    MyPercentIndicator(
                      percent: 0.39,
                      bloodType: "O-",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}