import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobilecms/auth.dart';
import 'package:mobilecms/landingPage.dart';
import 'package:mobilecms/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: AnimatedSplashScreen(splash: Image(image: AssetImage('assets/orange.jpeg'),fit: BoxFit.fill,height: 500,width: 50,),duration: 3000,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.white,
        nextScreen: AuthPage()),



    // HomePage(),
    //AddProductScreen(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
final GoogleSignIn googleSignIn=GoogleSignIn();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Google Sign-In demo'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: _signInWithGoogle,
                child: Text('Sign-In with google',style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,

                ),))
          ],
        ),
      ),
    );
  }
}

_signInWithGoogle()async{

  final GoogleSignInAccount? googleUser=await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;
  final AuthCredential credential=GoogleAuthProvider.credential(idToken: googleAuth?.idToken,accessToken: googleAuth?.idToken);
  final FirebaseAuth user= (await firebaseAuth.signInWithCredential(credential)).user as FirebaseAuth;
}


