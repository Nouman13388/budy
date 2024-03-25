import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class UIHelper{
  static showAlertDialogue(BuildContext context, String title, String message){
    
    OneContext().showDialog(builder: (ctx){
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          )
        ],
      );
    });
  }
}




