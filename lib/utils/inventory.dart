// 

import 'package:cloud_firestore/cloud_firestore.dart';

// Simple data model: One inventory object for every hospital
class Inventory {
  double groupAPlusPercentage;
  double groupAMinusPercentage;
  double groupBPlusPercentage;
  double groupBMinusPercentage;
  double groupABPlusPercentage;
  double groupABMinusPercentage;
  double groupOPlusPercentage;
  double groupOMinusPercentage;

  Inventory({
    required this.groupAPlusPercentage,
    required this.groupAMinusPercentage,
    required this.groupBPlusPercentage,
    required this.groupBMinusPercentage,
    required this.groupABPlusPercentage,
    required this.groupABMinusPercentage,
    required this.groupOPlusPercentage,
    required this.groupOMinusPercentage,
  });
}

Future<Map<String, Inventory>> fetchInventories() async {
  Map<String, Inventory> inv = {};
  
  final inventoryRef =  FirebaseFirestore.instance.collection("inventories");
  await inventoryRef.get().then(
    (querySnapshot) {
      print("Successfully fetched fetchInventories");
      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        inv[docSnapshot.id] = Inventory(
          groupAPlusPercentage: double.parse(docSnapshot.data()["A+"]),
          groupAMinusPercentage: double.parse(docSnapshot.data()["A-"]),
          groupBPlusPercentage: double.parse(docSnapshot.data()["B+"]),
          groupBMinusPercentage: double.parse(docSnapshot.data()["B-"]),
          groupABPlusPercentage: double.parse(docSnapshot.data()["AB+"]),
          groupABMinusPercentage: double.parse(docSnapshot.data()["AB-"]),
          groupOPlusPercentage: double.parse(docSnapshot.data()["O+"]),
          groupOMinusPercentage: double.parse(docSnapshot.data()["O-"]),
        );
      }
    },
    onError: (e) {
      throw Exception("Failed to fetch all inventories: $e");
    },
  );

  return inv;
}