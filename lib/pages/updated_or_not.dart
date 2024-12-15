import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybb/pages/update_user_profile_page.dart';
import 'package:mybb/pages/user_profile_page.dart';

Future<bool> fetchUserProfileUpdatedOrNot() async {
  Map<String, dynamic> finalData = {};
  await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then(
    (DocumentSnapshot doc) {
      if (doc.exists){
        final data = doc.data() as Map<String, dynamic>;
        finalData = data;
      }
    },
    onError: (e) => print("Error getting document: $e"),
  );

  bool ts = finalData["updatedOrNot"];
  return ts;
}

class UserProfileUpdatedOrNot extends StatefulWidget {

  const UserProfileUpdatedOrNot({super.key});

  @override
  State<UserProfileUpdatedOrNot> createState() => _UserProfileUpdatedOrNotState();
}

class _UserProfileUpdatedOrNotState extends State<UserProfileUpdatedOrNot>
{
  late Future<bool> userProfileUpdatedOrNot;
  
  @override
  void initState() {
    super.initState();
    userProfileUpdatedOrNot = fetchUserProfileUpdatedOrNot();
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Center(
        child: FutureBuilder(future: userProfileUpdatedOrNot, builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}: ${snapshot.stackTrace}');
          } else if (snapshot.hasData) {
            if (snapshot.data! == true) {
              return const UserProfilePage();
            } else {
              return const UpdateUserProfilePage();
            }
          }
        
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}