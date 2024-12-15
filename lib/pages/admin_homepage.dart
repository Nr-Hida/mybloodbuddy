import 'package:flutter/material.dart';
import 'package:mybb/components/blood_stock_inventory.dart';
import 'package:mybb/components/blood_type_donor_list.dart';
import 'package:mybb/utils/inventory.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  late Future<Map<String, Inventory>> inventories;
  late double aplus = 0.0;
  late double aminus = 0.0;
  late double bplus = 0.0;
  late double bminus = 0.0;
  late double abplus = 0.0;
  late double abminus = 0.0;
  late double oplus = 0.0;
  late double ominus = 0.0;

  @override
  void initState() {
    super.initState();
    inventories = fetchInventories();
  }

  void processInventories(Map<String, Inventory> invs) {
    for (var inv in invs.keys) {
      print(inv);
      aplus += invs[inv]!.groupAPlusPercentage;
      aminus += invs[inv]!.groupAMinusPercentage;
      bplus += invs[inv]!.groupBPlusPercentage;
      bminus += invs[inv]!.groupBMinusPercentage;
      abplus += invs[inv]!.groupABPlusPercentage;
      abminus += invs[inv]!.groupABMinusPercentage;
      oplus += invs[inv]!.groupOPlusPercentage;
      ominus += invs[inv]!.groupOMinusPercentage;

      // Average it out
      aplus = aplus / invs.length;
      aminus = aminus / invs.length;
      bplus = bplus / invs.length;
      bminus = bminus / invs.length;
      abplus = abplus / invs.length;
      abminus = abminus / invs.length;
      oplus = oplus / invs.length;
      ominus = ominus / invs.length;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: inventories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              processInventories(snapshot.data!);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BloodTypeDonorList(),
                  BloodStockInventory(
                    // inventories: inventories
                    aplus: aplus,
                    aminus: aminus,
                    bplus: bplus,
                    bminus: bminus,
                    abplus: abplus,
                    abminus: abminus,
                    oplus: oplus,
                    ominus: ominus,
                  ),
                ]
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}: ${snapshot.stackTrace}');
            }

            return const CircularProgressIndicator();
          }
        )
      )
    );
  }
}