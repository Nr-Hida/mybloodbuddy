// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mybb/components/blood_type_donor_card.dart';
import 'package:mybb/components/my_appbar.dart';
import 'package:mybb/components/my_textfield.dart';
import 'package:mybb/utils/enums.dart';
import 'package:mybb/utils/user.dart' as mybb_user;

class AdminBloodtypeDonorList extends StatefulWidget {
  const AdminBloodtypeDonorList({
    super.key,
  });

  @override
  State<AdminBloodtypeDonorList> createState() => _AdminBloodtypeDonorListState();
}

class _AdminBloodtypeDonorListState extends State<AdminBloodtypeDonorList> {
  late Future<Map<String, dynamic>> donors;
  
  // text editing controllers
  final filterDonorController = TextEditingController();
  String filter = "";

  @override
  void initState() {
    super.initState();
    filterDonorController.addListener(() {
      filter = filterDonorController.text;
      setState(() {});
    });
    donors = mybb_user.fetchUserForAdmin();
  }

  @override
  void dispose() {
    filterDonorController.dispose();
    super.dispose();
  }

  Widget buildBloodTypeDonorCard({required BloodTypeDonorCard btdc}) {
    return BloodTypeDonorCard(
      fullName: btdc.fullName,
      bloodType: btdc.bloodType,
      ic: btdc.ic,
      phone: btdc.phone,
      lastDonated: btdc.lastDonated,
      marriageStatus: btdc.marriageStatus,
      profilePicture: btdc.profilePicture,
      dob: btdc.dob,
      weight: btdc.weight,
      height: btdc.height,
      address: btdc.address,
      race: btdc.race,
      email: btdc.email,
      gender: btdc.gender,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloodType = ModalRoute.of(context)!.settings.arguments as String;
    
    return SafeArea(
      child: Scaffold(
        appBar: MyAppbar(
          mainAxisAlignment: MainAxisAlignment.start,
          leadingIcon: Container(),
          title: Text("Type $bloodType Blood", style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          )),
        ),
        body: FutureBuilder(
          future: donors,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // const lastDonationDate = snapshot.data![donor]["lastDonated"].toDate();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    MyTextfield(
                      controller: filterDonorController,
                      hintText: "Search for donor(s)",
                      obscureText: false
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: Text(
                        "* search donor by their name or IC number",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12.0
                        ),
                      ),
                    ),
                    const ListTile(
                      title: Text("ALL DONORS"),
                    ),
                    ...snapshot.data!.keys.map((donor) {
                      // If filter is empty,
                      // > then check if the donors' bloodType are the same as the one admin wants to see.
                      // > Show the donors' card if it matches, otherwise show empty Container().
                      // If filter is NOT empty,
                      // > then check if the donors' IC or fullName contains the lowercased filter terms/queries.
                      // > Show the donors' card if it matches, otherwise show empty Container().
                      return filter.isEmpty
                      ? formatBloodTypeWithoutRhesus(BloodType.values[snapshot.data![donor]["bloodType"]]) == bloodType
                      || formatBloodType(BloodType.values[snapshot.data![donor]["bloodType"]]) == "Undetermined"
                        ? buildBloodTypeDonorCard(
                          btdc: BloodTypeDonorCard(
                            fullName: snapshot.data![donor]["fullName"],
                            bloodType: formatBloodType(BloodType.values[snapshot.data![donor]["bloodType"]]),
                            ic: snapshot.data![donor]["ic"],
                            phone: snapshot.data![donor]["phone"],
                            lastDonated: "${snapshot.data![donor]["lastDonated"].toDate().day}/${snapshot.data![donor]["lastDonated"].toDate().month}/${snapshot.data![donor]["lastDonated"].toDate().year}",
                            marriageStatus: formatMarriageStatus(MarriageStatus.values[snapshot.data![donor]["marriageStatus"]]),
                            profilePicture: snapshot.data![donor]["profilePicture"],
                            // dob: "${snapshot.data![donor]["dob"].toDate().day}/${snapshot.data![donor]["dob"].toDate().month}/${snapshot.data![donor]["dob"].toDate().year}",
                            dob: snapshot.data![donor]["dob"],
                            weight: snapshot.data![donor]["weight"].toDouble(),
                            height: snapshot.data![donor]["height"].toDouble(),
                            address: snapshot.data![donor]["address"],
                            race: formatRace(Race.values[snapshot.data![donor]["race"]]),
                            email: snapshot.data![donor]["email"],
                            gender: formatGender(Gender.values[snapshot.data![donor]["gender"]]),
                          )
                        )
                        : Container()
                      : (
                        snapshot.data![donor]["ic"].contains(filter.toLowerCase())
                        ||
                        snapshot.data![donor]["fullName"].toLowerCase().contains(filter.toLowerCase())
                        )
                        &&
                        (
                        formatBloodTypeWithoutRhesus(BloodType.values[snapshot.data![donor]["bloodType"]]) == bloodType
                        ||
                        formatBloodType(BloodType.values[snapshot.data![donor]["bloodType"]]) == "Undetermined"
                        )
                        ? buildBloodTypeDonorCard(
                            btdc: BloodTypeDonorCard(
                              fullName: snapshot.data![donor]["fullName"],
                              bloodType: formatBloodType(BloodType.values[snapshot.data![donor]["bloodType"]]),
                              ic: snapshot.data![donor]["ic"],
                              phone: snapshot.data![donor]["phone"],
                              lastDonated: "${snapshot.data![donor]["lastDonated"].toDate().day}/${snapshot.data![donor]["lastDonated"].toDate().month}/${snapshot.data![donor]["lastDonated"].toDate().year}",
                              marriageStatus: formatMarriageStatus(MarriageStatus.values[snapshot.data![donor]["marriageStatus"]]),
                              profilePicture: snapshot.data![donor]["profilePicture"],
                              // dob: "${snapshot.data![donor]["dob"].toDate().day}/${snapshot.data![donor]["dob"].toDate().month}/${snapshot.data![donor]["dob"].toDate().year}",
                              dob: snapshot.data![donor]["dob"],
                              weight: snapshot.data![donor]["weight"].toDouble(),
                              height: snapshot.data![donor]["height"].toDouble(),
                              address: snapshot.data![donor]["address"],
                              race: formatRace(Race.values[snapshot.data![donor]["race"]]),
                              email: snapshot.data![donor]["email"],
                              gender: formatGender(Gender.values[snapshot.data![donor]["gender"]]),
                            )
                          )
                          : Container();
                    }),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}: ${snapshot.stackTrace}');
            }

            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}