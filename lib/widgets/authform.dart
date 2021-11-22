import 'dart:io';

import 'package:chatapp/widgets/pickers.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String user, String pass, File? userimag,
      bool islogin, BuildContext ctx) sub;
  final bool isloading;

  AuthForm(this.sub, this.isloading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formkey = GlobalKey<FormState>();

  String email = '';

  String username = '';

  String password = '';
  var islogin = true;
  File? userimage;
  void picked(File p) {
    userimage = p;
  }

  void submit() {
    final isvalid = formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (userimage==null && !islogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please pick an image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isvalid) {
      formkey.currentState!.save();
      widget.sub(email.trim(), username.trim(), password.trim(),userimage,
          islogin, context);
    
 
  }}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(30),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
              if(!islogin)  Picker(
                  picked,
                
                ),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return "Please Enter a valid Email Address";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val.toString();
                  },
                  // onChanged:
                ),
                if (!islogin)
                  TextFormField(
                    key: ValueKey('user'),
                    decoration: InputDecoration(labelText: 'User Name'),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "must have an  user name";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      username = val.toString();
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length <= 5) {
                      return "Must contain at least 5 characters";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    password = v.toString();
                  },
                ),
                SizedBox(height: 10),
                if (widget.isloading)
                  Center(child: CircularProgressIndicator()),
                if (!widget.isloading)
                  ElevatedButton(
                    onPressed: submit,
                    child: Text(islogin ? "Login" : "Create"),
                  ),
                if (!widget.isloading)
                  Text(
                    "or",
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                if (!widget.isloading)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          islogin = !islogin;
                        });
                      },
                      child: Text(islogin ? "Create a new account" : "Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
