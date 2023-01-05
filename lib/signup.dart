import 'package:flutter/material.dart';
import 'package:mobilecms/loginScreen.dart';

import 'helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController SignUpNameController = TextEditingController();
  final TextEditingController SignUpPasswordController = TextEditingController();
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xff25bcbb);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: secondaryColor,

      appBar: AppBar(
        title: Text('Sign Up ',textAlign: TextAlign.center,),
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.symmetric(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: SignUpNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Enter User Name",




                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,

                  controller: SignUpPasswordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Enter Password",


                  ),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: SignUpPasswordController,
                  decoration: InputDecoration(

                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "RE-Enter Password",

                  ),),
              ),

              ElevatedButton(onPressed: (){
                AuthenticationHelper th=AuthenticationHelper();
                th.signUp(email:SignUpNameController.text , password: SignUpPasswordController.text).then((result)
                {
                  if (result==null){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
                }
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registered Successfully')));
                });

              },
                  child:Text('Register') )

            ],
          ),
        ),
      ),
    );
  }
}
