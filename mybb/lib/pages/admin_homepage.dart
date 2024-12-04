import 'package:flutter/material.dart';
import 'package:mybb/components/blood_stock_inventory.dart';
import 'package:mybb/components/blood_type_donor_list.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BloodTypeDonorList(),
            BloodStockInventory(),
          ]
        ),
    ));
  }
}