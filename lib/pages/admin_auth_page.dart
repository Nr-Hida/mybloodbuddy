import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybb/pages/admin_login_page.dart';
import 'package:mybb/pages/admin_home.dart';

class AdminAuthPage extends StatelessWidget {
  const AdminAuthPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot)
      {
        // user is logged in
        if (snapshot.hasData)
        {
          return const AdminHome();
        }
        else
        { // user is NOT logged in
          return const AdminLoginPage();
        }
      }),
    );
  }
}