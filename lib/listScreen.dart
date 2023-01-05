import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xff25bcbb);
  TextEditingController productNameController=TextEditingController();
  TextEditingController brandController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController imageUrlController=TextEditingController();
  CollectionReference ref=FirebaseFirestore.instance.collection('product');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
          backgroundColor: secondaryColor,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (_,AsyncSnapshot<QuerySnapshot> snapshot,){
          if (snapshot.hasData ){
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
              itemBuilder: (context,index){
              var xxx=snapshot.data?.docs[index];


              return ListTile(title: Text(xxx!['name'], style: TextStyle(color: Colors.white),

              ),
                  leading: IconButton(icon:Icon( Icons.edit),color:Colors.white ,
                    onPressed: () {
                    productNameController.text=xxx['name'];
                     brandController.text=xxx['brand'];
                     priceController.text=xxx['price'];
                     //imageUrlController.text=xxx['imagrUrl'];



                     showDialog(context: context, builder: (context)=>Dialog(
                       child: Container(
                         color: secondaryColor,
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ListView(
                             shrinkWrap: true ,

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
                                 snapshot.data?.docs[index].reference.update({
                                   "name":productNameController.text,
                                   "brand":brandController.text,
                                   "price":priceController.text,
                                   //"imageUrl":imageUrlController.text,
                                 }).whenComplete(() => Navigator.pop(context));

                               },
                                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                 child:Text('Update in DataBase',style: TextStyle(
                                   color: Colors.white,fontSize: 15,
                                 ),),

                               ),
                               ElevatedButton(onPressed: (){
                                 snapshot.data?.docs[index].reference.delete().whenComplete(() => Navigator.pop(context));
                               },
                                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
                                 child:Text('Delete DataBase',style: TextStyle(
                                   color: Colors.white,fontSize: 15,
                                 ),),

                               )

                             ],
                           ),
                         ),
                       ),
                     ));
                    },),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(xxx!['brand'], style: TextStyle(color: Colors.blue)),
                      Text(xxx!['price'], style: TextStyle(color: Colors.green)),
                      
                    ],
                  ),
                trailing: Image.network(xxx!['imageUrl'],height: 100,width: 100,fit: BoxFit.cover),
              );

              });

          }else if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading...',style: TextStyle(color: Colors.white),);


          }else{
            return Text('');
          }
        },

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
