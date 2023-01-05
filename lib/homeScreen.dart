import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilecms/loginScreen.dart';

import 'helper.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
      IconButton(
      icon: const Icon(Icons.logout),
        tooltip: 'Show Snackbar',
        onPressed: () async {

          try {
            AuthenticationHelper te=AuthenticationHelper();
            te.signOut().then((result) {
              if (result == null) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign Out')));

            });
          }

          on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
            }
          }
        },
      )
        ],
        title:Text(' Product Screen '),
      ),
    );
  }
}
