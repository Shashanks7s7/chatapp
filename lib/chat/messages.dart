import 'package:chatapp/chat/messagebubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import'package:flutter/material.dart';
class Messages extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
     
    return FutureBuilder(
      future:  Future.value(auth.FirebaseAuth.instance.currentUser),
      builder: (ctx, AsyncSnapshot futuresnapshot){
        if(futuresnapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        return   StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy(
             'createdat',
             descending: true

      ).snapshots(),
      builder: ( ctx,  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child:MessageBubble(documents[index]['text'],documents[index]['username'],documents[index]['imageurl'],documents[index]['userId']==futuresnapshot.data!.uid,keys:ValueKey(documents[index].id)),
            ),
          );
      }
    );

      });
    
  
  }
}