import 'package:flutter/material.dart';
import 'package:mybb/components/my_percent_indicator.dart';
import 'package:mybb/utils/inventory.dart';

class BloodStockInventory extends StatelessWidget {
  // Future<Map<String, Inventory>> inventories;
  double aplus;
  double aminus;
  double bplus;
  double bminus;
  double abplus;
  double abminus;
  double oplus;
  double ominus;
  
  BloodStockInventory({
    super.key,
    // required this.inventories,
    required this.aplus,
    required this.aminus,
    required this.bplus,
    required this.bminus,
    required this.abplus,
    required this.abminus,
    required this.oplus,
    required this.ominus,
  });

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPercentIndicator(
                      percent: aplus,
                      bloodType: "A+",
                    ),
                    MyPercentIndicator(
                      percent: aminus,
                      bloodType: "A-",
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPercentIndicator(
                      percent: bplus,
                      bloodType: "B+",
                    ),
                    MyPercentIndicator(
                      percent: bminus,
                      bloodType: "B-",
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPercentIndicator(
                      percent: abplus,
                      bloodType: "AB+",
                    ),
                    MyPercentIndicator(
                      percent: abminus,
                      bloodType: "AB-",
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPercentIndicator(
                      percent: oplus,
                      bloodType: "O+",
                    ),
                    MyPercentIndicator(
                      percent: ominus,
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