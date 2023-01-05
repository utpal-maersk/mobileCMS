import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilecms/homeScreen.dart';
import 'package:mobilecms/loginScreen.dart';

import 'landingPage.dart';
class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder <User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          //user is logged in

          if (snapshot.hasData){
            return HomeScreen();
          }
          else {
            return LandingPage();
          }

        },
      ),

    );
  }
}
