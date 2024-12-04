import 'package:flutter/material.dart';
import 'package:mybb/components/blood_type_donor_card.dart';
import 'package:mybb/components/my_appbar.dart';
import 'package:mybb/components/my_textfield.dart';

class AdminBloodtypeDonorList extends StatefulWidget {
  const AdminBloodtypeDonorList({
    super.key,
  });

  @override
  State<AdminBloodtypeDonorList> createState() => _AdminBloodtypeDonorListState();
}

class _AdminBloodtypeDonorListState extends State<AdminBloodtypeDonorList> {
  // text editing controllers
  final filterDonorController = TextEditingController();
  String filter = "";
  final donors = [
    const BloodTypeDonorCard(
      fullName: "Muhd Aiman Bin Azhar",
      bloodType: "A-",
      ic: "020701-14-0231",
      phone: "+6012-202-2687",
      lastDonated: "02/12/2022",
    ),
    const BloodTypeDonorCard(
      fullName: "Donald Bin Trump",
      bloodType: "A+",
      ic: "460614-01-XXXX",
      phone: "+6012-202-XXXX",
      lastDonated: "02/12/2022",
    ),
    const BloodTypeDonorCard(
      fullName: "Kamala Binti Harris",
      bloodType: "A+",
      ic: "641020-14-XXXX",
      phone: "+6012-202-XXXX",
      lastDonated: "02/12/2022",
    ),
    const BloodTypeDonorCard(
      fullName: "Kanye Bin West",
      bloodType: "A+",
      ic: "770608-14-XXXX",
      phone: "+6012-202-XXXX",
      lastDonated: "02/12/2022",
    ),
    const BloodTypeDonorCard(
      fullName: "Taylor Binti Swift",
      bloodType: "A-",
      ic: "891213-14-XXXX",
      phone: "+6012-202-XXXX",
      lastDonated: "02/12/2022",
    ),
  ];

  @override
  void initState() {
    super.initState();
    filterDonorController.addListener(() {
      filter = filterDonorController.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    filterDonorController.dispose();
    super.dispose();
  }

  Widget bloodTypeDonorCard(
    String fullName,
    String bloodType,
    String ic,
    String phone,
    String lastDonated,
  ) {
    return BloodTypeDonorCard(
      fullName: fullName,
      bloodType: bloodType,
      ic: ic,
      phone: phone,
      lastDonated: lastDonated
    );
  }

  Widget buildBloodTypeDonorCard({required BloodTypeDonorCard btdc}) {
    return BloodTypeDonorCard(
      fullName: btdc.fullName,
      bloodType: btdc.bloodType,
      ic: btdc.ic,
      phone: btdc.phone,
      lastDonated: btdc.lastDonated
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
            fontSize: 30.0,
            fontWeight: FontWeight.bold
          )),
        ),
        body: Padding(
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
              ...donors.map((donor) {
                return filter.isEmpty
                ? buildBloodTypeDonorCard(btdc: donor)
                : donor.ic.contains(filter.toLowerCase()) || donor.fullName.toLowerCase().contains(filter.toLowerCase())
                  ? buildBloodTypeDonorCard(btdc: donor)
                  : Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}