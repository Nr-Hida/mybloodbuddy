import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybb/pages/login_page.dart';
import 'package:mybb/pages/user_home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        // user is logged in
        if (snapshot.hasData)
        {
          return const UserHome();
        }
        else
        { // user is NOT logged in
          return LoginPage();
        }
      }),
    );
  }
}