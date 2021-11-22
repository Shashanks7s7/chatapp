import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Picker extends StatefulWidget {
  final Function(File imagepicked) image;

  Picker(this.image);


  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  File? pickedimage;
  void pickimage() async {
    final imagep=ImagePicker();
    final img=await imagep.getImage(source: ImageSource.gallery,imageQuality: 50,maxWidth: 150);
       setState(() {
         pickedimage=File(img!.path);
       });
       widget.image(pickedimage!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
         CircleAvatar(
           backgroundColor: Colors.white,
           backgroundImage: pickedimage!=null?FileImage(pickedimage!):null,
                                    radius: 40,
                                    ),
                               TextButton.icon(onPressed: pickimage, label: Text("Add Image"),icon: Icon(Icons.image),),
      ],
      
    );
  }
}