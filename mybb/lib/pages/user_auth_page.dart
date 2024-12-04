import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybb/pages/user_login_page.dart';
import 'package:mybb/pages/user_home.dart';

class UserAuthPage extends StatelessWidget {
  const UserAuthPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot)
      {
        // user is logged in
        if (snapshot.hasData)
        {
          return const UserHome();
        }
        else
        { // user is NOT logged in
          return const UserLoginPage();
        }
      }),
    );
  }
}