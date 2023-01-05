import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilecms/listScreen.dart';
import 'package:mobilecms/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Import the generated file

import 'helper.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xff25bcbb);
  TextEditingController productNameController=TextEditingController();
  TextEditingController brandController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController imageUrlController=TextEditingController();
  late Map<String,dynamic>productToAdd;
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('product');

  void clearText() {
    productNameController.clear();
    brandController.clear();
    priceController.clear();
    imageUrlController.clear();
  }
  addProduct(){

    productToAdd={
      "name":productNameController.text,
      "brand":brandController.text,
      "price":priceController.text,
      "imageUrl":imageUrlController.text,
    };
    
    collectionReference.add(productToAdd).whenComplete(
          () =>  ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Added to Database')
        )),


    );
    clearText();


  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor ,

      appBar: AppBar(
        backgroundColor: secondaryColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ListScreen()));
          }, icon: Icon(Icons.folder_open)),
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
      ),


        ],
        title:Text('Mobile CMS Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(height: 10,),
          _buildTextField(productNameController,'Name'),
            SizedBox(height: 10,),

            _buildTextField(brandController,'Brand'),
            SizedBox(height: 10,),

            _buildTextField(priceController,'Price'),
            SizedBox(height: 10,),

            _buildTextField(imageUrlController,'Image Url'),
            SizedBox(height: 10,),

            ElevatedButton(onPressed: (){

              addProduct();

            },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                child:Text('Add Product to Database',style: TextStyle(
                  color: Colors.white,fontSize: 15,
                ),),

            )

          ],
        ),
      ),
    );


  }

  _buildTextField(TextEditingController controller,String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color:  secondaryColor, border: Border.all(color: Colors.white)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            border: InputBorder.none),
      ),
    );
  }
}
