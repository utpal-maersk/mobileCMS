import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobilecms/signup.dart';

import 'helper.dart';
import 'homeScreen.dart';
import 'main.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xff25bcbb);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=GoogleSignIn();
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFE44E11),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign in to TGD and continue',
                textAlign: TextAlign.center,
                style:
                GoogleFonts.openSans(color: Colors.white, fontSize: 28),
              ),
              SizedBox(height: 20),
              Text(
                'Enter your email and password below to continue to the The Growing Developer and let the learning begin!',
                textAlign: TextAlign.center,
                style:
                GoogleFonts.openSans(color: Colors.white, fontSize: 14),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTextField(
                      nameController, Icons.account_circle, 'Username'),
                  SizedBox(height: 10),
                  _buildTextField(passwordController, Icons.lock, 'Password'),
                  SizedBox(height: 30),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: ()async {



                      try {
                        // UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        //     email: nameController.text,
                        //     password: passwordController.text,
                        // );

                        AuthenticationHelper te=AuthenticationHelper();
                        te.signIn(email: nameController.text, password: passwordController.text).then((result) {
                          if (result == null) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                        });


                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                      }

                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    color: Colors.lightGreen,
                    child: Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 10),

              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: _signInWithGoogle,
                color: Colors.lightBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.google),
                    SizedBox(width: 10),
                    Text('Sign-in using Google',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                textColor: Colors.white,
              ),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
              }, child: Text('Signup',style: TextStyle(color: Colors.white,fontSize: 15,),)),
              SizedBox(height: 100),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildFooterLogo(),
              ),


            ],
          ),
        ),
      ),
    );
  }


  _buildTextField(TextEditingController controller, IconData icon,
      String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Color(0xFFE44E11), border: Border.all(color: Colors.white)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

  _buildFooterLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/splashorange.jpeg',
          height: 80,
        ),
        Text('The Growing Developer',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

_signInWithGoogle()async{

  final GoogleSignInAccount? googleUser=await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;
  final AuthCredential credential=GoogleAuthProvider.credential(idToken: googleAuth?.idToken,accessToken: googleAuth?.idToken);
  final FirebaseAuth user= (await firebaseAuth.signInWithCredential(credential)).user as FirebaseAuth;
}
