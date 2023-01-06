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
  final TextEditingController ReSignupPasswordController=TextEditingController();
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
              SizedBox(height: 10,),
              _buildTextField(SignUpNameController, Icons.account_box, 'UserName'),
              SizedBox(height: 10,),
              _buildTextField(SignUpPasswordController, Icons.password, 'Password'),
              SizedBox(height: 10,),
              _buildTextField(ReSignupPasswordController, Icons.password, 'Re-Enter Password'),
              SizedBox(height: 10,),
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
  _buildTextField(TextEditingController controller, IconData icon,
      String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.white)),
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
}
