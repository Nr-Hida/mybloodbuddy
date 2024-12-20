import 'package:flutter/material.dart';
import 'package:mybb/components/blood_stock_inventory.dart';
import 'package:mybb/components/blood_type_donor_list.dart';
import 'package:mybb/utils/enums.dart';
import 'package:mybb/utils/inventory.dart';
import 'package:mybb/utils/user.dart' as mybb_user;

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  // late Future<Map<String, Inventory>> inventories;
  late Future<Map<String, dynamic>> donors;
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
    // inventories = fetchInventories();
    donors = mybb_user.fetchUserForAdmin();
  }

  // void processInventories(Map<String, Inventory> invs) {
  void processUsers(Map<String, dynamic> users) {
    print(users);
    int aplusTotal = 0;
    int aminusTotal = 0;
    int bplusTotal = 0;
    int bminusTotal = 0;
    int abplusTotal = 0;
    int abminusTotal = 0;
    int oplusTotal = 0;
    int ominusTotal = 0;
    int undetTotal = 0;
    for (var user in users.keys) {
      if (users[user]["bloodType"] == BloodType.groupAplus.index) {
        aplus += 1.0;
        aplusTotal += 1;
      } else if (users[user]["bloodType"] == BloodType.groupAminus.index) {
        aminus += 1.0;
        aminusTotal += 1;
      } else if (users[user]["bloodType"] == BloodType.groupBplus.index) {
        bplus += 1.0;
        bplusTotal += 1;
      } else if (users[user]["bloodType"] == BloodType.groupBminus.index) {
        bminus += 1.0;
        bminusTotal += 1;
      } else if (users[user]["bloodType"] == BloodType.groupABplus.index) {
        abplus += 1.0;
        abplusTotal += 1;
      } else if (users[user]["bloodType"] == BloodType.groupABminus.index) {
        abminus += 1.0;
        abminusTotal += 1;
      } else if (users[user]["bloodType"] == BloodType.groupOplus.index) {
        oplus += 1.0;
        oplusTotal += 1;
      } else if (users[user]["bloodType"] == BloodType.groupOminus.index) {
        ominus += 1.0;
        ominusTotal += 1;
      } else { // users[user]["bloodType"] == BloodType.undetermined
        undetTotal += 1;
      }
      
      // aplus += invs[inv]!.groupAPlusPercentage;
      // aminus += invs[inv]!.groupAMinusPercentage;
      // bplus += invs[inv]!.groupBPlusPercentage;
      // bminus += invs[inv]!.groupBMinusPercentage;
      // abplus += invs[inv]!.groupABPlusPercentage;
      // abminus += invs[inv]!.groupABMinusPercentage;
      // oplus += invs[inv]!.groupOPlusPercentage;
      // ominus += invs[inv]!.groupOMinusPercentage;
    }
      
    // aplus /= aplusTotal == 0 ? 1 : aplusTotal;
    // aminus /= aminusTotal == 0 ? 1 : aminusTotal;
    // bplus /= bplusTotal == 0 ? 1 : bplusTotal;
    // bminus /= bminusTotal == 0 ? 1 : bminusTotal;
    // abplus /= abplusTotal == 0 ? 1 : abplusTotal;
    // abminus /= abminusTotal == 0 ? 1 : abminusTotal;
    // oplus /= oplusTotal == 0 ? 1 : oplusTotal;
    // ominus /= ominusTotal == 0 ? 1 : ominusTotal;
      
    aplus /= users.length;
    aminus /= users.length;
    bplus /= users.length;
    bminus /= users.length;
    abplus /= users.length;
    abminus /= users.length;
    oplus /= users.length;
    ominus /= users.length;

    // Average it out
    // aplus = aplus / invs.length;
    // aminus = aminus / invs.length;
    // bplus = bplus / invs.length;
    // bminus = bminus / invs.length;
    // abplus = abplus / invs.length;
    // abminus = abminus / invs.length;
    // oplus = oplus / invs.length;
    // ominus = ominus / invs.length;
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: donors,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              processUsers(snapshot.data!);
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