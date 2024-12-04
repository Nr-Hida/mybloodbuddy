import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybb/components/my_button.dart';
import 'package:mybb/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          const Icon(Icons.lock, size: 50),
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
          )
        ],),
      ),
    );
  }
}