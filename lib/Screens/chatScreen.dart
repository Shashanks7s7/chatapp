
import 'package:chatapp/chat/messageinput.dart';
import 'package:chatapp/chat/messages.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 28,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).backgroundColor,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                    child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Log-Out'),
                  ],
                )),

                value: 'logout',
                //RaisedButton.icon(onPressed: (){FirebaseAuth.instance.signOut();}, icon: Icon(Icons.logout),label: Text("Log-Out"),)
              )
            ],
            onChanged: (item) {
              if (item == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body:/*StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),*/
      
      
      Container(
        child: Column(children: [
          Expanded(
            child: Messages(),
          ),
         // FittedBox(child: MessageBubble('hululu')),
          MessageInput()
        ]),
      ),
      
    );
  }
}
