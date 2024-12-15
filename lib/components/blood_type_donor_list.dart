import "package:flutter/material.dart";
import "package:mybb/components/my_bloodtype_donor_list_button.dart";

class BloodTypeDonorList extends StatelessWidget {
  const BloodTypeDonorList({super.key});
  
  @override
  Widget build(BuildContext context)
  {
    void showBloodTypeDonorList(String bloodType) {
      Navigator.pushNamed(context, "show_bloodtype_donor_list", arguments: bloodType);
    }
    
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("SELECT A BLOOD TYPE"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyBloodTypeDonorListBtn(text: "A", onTap: () => showBloodTypeDonorList("Group A")),
              MyBloodTypeDonorListBtn(text: "B", onTap: () => showBloodTypeDonorList("Group B")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyBloodTypeDonorListBtn(text: "AB", onTap: () => showBloodTypeDonorList("Group AB")),
              MyBloodTypeDonorListBtn(text: "O", onTap: () => showBloodTypeDonorList("Group O")),
            ],
          ),
        ],
      ),
    );
  }
}