import 'package:flutter/material.dart';
import 'package:mybb/pages/updated_or_not.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybb/pages/admin_auth_page.dart';
import 'package:mybb/pages/admin_login_page.dart';
import 'package:mybb/pages/admin_home.dart';
import 'package:mybb/pages/admin_bloodtype_donor_list.dart';
import 'package:mybb/pages/user_auth_page.dart';
import 'package:mybb/pages/user_login_page.dart';
import 'package:mybb/pages/user_home.dart';
import 'package:mybb/pages/user_profile_page.dart';
import "package:mybb/pages/user_confirm_appointment.dart";
import 'package:mybb/pages/user_review_booking.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser?.email == "admin@mybloodbuddy.com" ? const AdminAuthPage() : const UserAuthPage(),
      routes: {
        // ADMIN
        'admin_auth_page': (context) => const AdminAuthPage(),
        'admin_login': (context) => const AdminLoginPage(),
        'admin_home': (context) => const AdminHome(),
        // 'admin_settings': (context) => const AdminSettings(),
        'show_bloodtype_donor_list': (context) => const AdminBloodtypeDonorList(),
        // USER
        'user_auth_page': (context) => const UserAuthPage(),
        'user_login': (context) => const UserLoginPage(),
        'user_home': (context) => const UserHome(),
        // 'user_book_appointment': (context) => const UserBookAppointment(),
        // 'user_settings': (context) => const UserSettings(),
        'user_review_booking': (context) => const UserReviewBooking(),
        'user_confirm_appointment': (context) => const UserConfirmAppointment(),
        'user_profile_updated_or_not': (context) => const UserProfileUpdatedOrNot(),
        'user_profile': (context) => const UserProfilePage(),
      },
    );
  }
}
