import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MessageInput extends StatefulWidget {
   MessageInput({ Key? key }) : super(key: key);

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final  _textEditingController=new  TextEditingController();

  var enteredmessage='';

  void submit() async{
    FocusScope.of(context).unfocus();
    final user= await FirebaseAuth.instance.currentUser;
    final name= await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
  FirebaseFirestore.instance.collection('chat').add({
    'text':enteredmessage,
    'createdat':Timestamp.now(),
    'userId': user.uid,
    'username': name['username'] ,
    'imageurl':name['image_url']
  });
  _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container( 

       margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        
        children: [
        Expanded(
                  child: TextField(
            
            decoration:InputDecoration(hintText: 'Type a message',
            prefixIcon: Icon(Icons.emoji_emotions,),
            suffixIcon: Icon(Icons.camera),
        
            
            ),
            keyboardType: TextInputType.name,
            controller: _textEditingController,
            onChanged: (value){
               setState(() {
                 enteredmessage=value;
               });
            },
          ),
        ),
        IconButton(onPressed: enteredmessage.trim().isEmpty?null:submit, icon: Icon(Icons.send),  color:Theme.of(context).colorScheme.secondaryVariant,)
      ],
      
      ),
     );
  }
}