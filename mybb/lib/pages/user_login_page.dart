import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybb/components/mybloodbuddy_logo.dart';
import 'package:mybb/components/my_button.dart';
import 'package:mybb/components/my_textfield.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn()
  async {
    // show loading
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
    
    // check for admin email
    if (emailController.text == "admin@mybloodbuddy.com")
    {
      // pop the loading circle
        Navigator.pop(context);
        
        userNotFoundMessage();
    }
    else
    {
      // try sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
        );

        // pop the loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop the loading circle
        Navigator.pop(context);
        
        if (e.code == "user-not-found") {
          userNotFoundMessage();
        } else if (e.code == "wrong-password") {
          incorrectPasswordMessage();
        }
      }
    }
  }

  void userNotFoundMessage() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(title: Text("User Not Found"));
    });
  }

  void incorrectPasswordMessage() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(title: Text("Incorrect Password"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            const MyBloodBuddyLogo(imageFilename: "mybloodbuddy.png"),
            const SizedBox(height: 20),
            // welcome back
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text("Welcome back", style: TextStyle(
                    fontSize: 40,
                  )),
                ],
              ),
            ),
            // new to this app? sign up
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text("New to this app?"),
                  SizedBox(width: 4),
                  Text("Sign up", style: TextStyle(
                    color: Colors.blue
                  )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // email textfield
            MyTextfield(
              controller: emailController,
              hintText: "Email address",
              obscureText: false,
            ),
            const SizedBox(height: 10),
            // password textfield
            MyTextfield(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 10),
            // forgot password?
            const Text("Forgot your password?"),
            const SizedBox(height: 25),
            // log in button
            MyButton(
              text: "Log in",
              onTap: signUserIn,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Are you an admin?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Expanded(child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  )),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // log in as admin button
            MyButton(
              text: "Log in as admin",
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, "admin_auth_page")
              }
            ),
          ],
        ),
      ),
    );
  }
}