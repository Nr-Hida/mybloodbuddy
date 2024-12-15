import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:mybb/utils/enums.dart";
import "package:mybb/utils/user.dart" as mybb_user;

class User {
  final String fullName;
  final String email;
  final String address;
  final BloodType bloodType;
  final Timestamp dob;
  final Gender gender;
  final double height;
  final double weight;
  final String ic;
  final MarriageStatus marriageStatus;
  final String phone;
  final String profilePicture;
  final Race race;
  final int donationCount;

  User({
    required this.fullName,
    required this.email,
    required this.address,
    required this.bloodType,
    required this.dob,
    required this.gender,
    required this.height,
    required this.weight,
    required this.ic,
    required this.marriageStatus,
    required this.phone,
    required this.profilePicture,
    required this.race,
    required this.donationCount
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'email': String email,
        'full_name': String fullName,
        'dob': Timestamp dob,
        'address': String address,
        'blood_type': BloodType bloodType,
        'gender': Gender gender,
        'height': double height,
        'weight': double weight,
        'ic': String ic,
        'marriage_status': MarriageStatus marriageStatus,
        'phone': String phone,
        'profile_picture': String profilePicture,
        'race': Race race,
        'donationCount': int donationCount
      } =>
        User(
          email: email.toString(),
          fullName: fullName.toString(),
          dob: dob,
          address: address.toString(),
          bloodType: bloodType,
          gender: gender,
          height: height,
          weight: weight,
          ic: ic,
          marriageStatus: marriageStatus,
          phone: phone,
          profilePicture: profilePicture,
          race: race,
          donationCount: donationCount,
        ),
      FormatException fe => throw FormatException('Failed to load user: $fe'),
      Exception e => throw Exception("Exception thrown: $e"),
      // _ => throw Exception("Not any kind of known Exception. Please report this error and we'll compensate you monetarily for your time."),
      _ => throw Exception("Not any kind of known Exception.\nPlease report this error."),
    };
  }
}

// Fetch user for user
Future<mybb_user.User> fetchUser() async {
  Map<String, dynamic> finalData = {};
  final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
  await docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      finalData = data;
    },
    onError: (e) => {
      throw Exception("Failed to fetch user: $e")
    },
  );

  return User(
    email: finalData["email"] != "" ? finalData["email"] : "",
    fullName: finalData["fullName"] ?? "",
    dob: finalData["dob"] ?? Timestamp(0, 0),
    address: finalData["address"] ?? "",
    bloodType: BloodType.values[finalData["bloodType"] ?? 0],
    gender: Gender.values[finalData["gender"] ?? 0],
    height: double.parse(finalData["height"].toString()),
    weight: double.parse(finalData["weight"].toString()),
    ic: finalData["ic"] ?? "",
    marriageStatus: MarriageStatus.values[finalData["marriageStatus"] ?? 0],
    phone: finalData["phone"] ?? "",
    profilePicture: finalData["profilePicture"] ?? "",
    race: Race.values[finalData["race"] ?? 0],
    donationCount: finalData["donationCount"] ?? 0,
  );
}

// Fetch user for admin
Future<Map<String, dynamic>> fetchUserForAdmin() async {
  Map<String, dynamic> finalData = {};
  final docRef = FirebaseFirestore.instance.collection("users");
  await docRef.get().then(
    (querySnapshot) {
      print("Succesfully fetched fetchUserForAdmin");
      for (var docSnapshot in querySnapshot.docs) {
        finalData[docSnapshot.id] = docSnapshot.data();
      }
    },
    onError: (e) => {
      throw Exception("Failed to fetch user: $e")
    },
  );

  return finalData;
}