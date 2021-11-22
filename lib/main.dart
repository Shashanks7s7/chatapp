import 'package:chatapp/Screens/authscreen.dart';
import 'package:chatapp/Screens/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
    primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.dark(background:Colors.white,
        onSecondary: Colors.grey,),
        buttonTheme: ButtonTheme.of(context).copyWith(
           buttonColor: Colors.pink,
             textTheme: ButtonTextTheme.primary,
             shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(200))
        )

      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,streamsnapshot)=>
         streamsnapshot.hasData?ChatScreen():AuthScreen()
        ,)
       
    );
  }
}
