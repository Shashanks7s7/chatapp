
import 'dart:io';

import 'package:chatapp/widgets/authform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({ Key? key }) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  

  bool loading=false;
  final auth= FirebaseAuth.instance;
  void submit(String email,String username, String password,File? userimage, bool islogin, BuildContext ctx) async{
        UserCredential authResult;
       
  try{   setState(() {
          loading=true;
        });
    
    if(islogin)
    {
   authResult= await auth.signInWithEmailAndPassword(email: email, password: password);
    }
    else{
authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
   final ref= FirebaseStorage.instance.ref().child('userimage').child(authResult.user!.uid + ".jpg");
    print('await yaha garxa hahahahahhhahhahahhahahahahha');
     await  ref.putFile(userimage!).whenComplete(() => ref.getDownloadURL().then((value) {  FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
      'username':username,
      'email':email,
      'image_url':value
    });}));
  // Future<String> urla =  ref.getDownloadURL();
     

     
  /*  await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
      'username':username,
      'email':email,
      //'image_url':urll
    });*/}
    }on PlatformException catch(error){
       var message= 'An Error Occurred';
       if(error.message != null){
         message=error.message.toString();
       } 
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
     
     setState(() {
       loading=false;
     });
      
    }catch(error){
      print(error);
      setState(() {
        loading=false;
      });

       
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: AuthForm(submit,loading)
          
        
      
      
    );
  }
}