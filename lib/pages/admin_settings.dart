import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminSettings extends StatelessWidget {
  const AdminSettings({super.key});
  
  @override
  Widget build(BuildContext context)
  {
    void signAdminOut() async {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to logout from your account?"),
          actionsPadding: const EdgeInsets.all(8.0),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // remove dialog
                Navigator.pop(context);
              },
              child: const Text('Logout')
            ),
            ElevatedButton(
              onPressed: () {
                // remove dialog
                Navigator.pop(context);
              },
              child: const Text('No')
            ),
          ],
        );
      });
    }
    
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const ListTile(
                title: Text("Admin Account"),
                // leading: Icon(Icons.arrow_forward_ios),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                    bottom: Radius.circular(10)
                  )
                ),
                child: ListTile(
                  title: const Text("Logout"),
                  trailing: const Icon(Icons.logout),
                  onTap: signAdminOut,
                ),
              )
            ],
          ),
        )
      )
    );
  }
}