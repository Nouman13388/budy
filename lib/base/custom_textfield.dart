// ignore_for_file: camel_case_types, must_be_immutable

import 'package:budy/utils/mycolors.dart';
import 'package:flutter/material.dart';
class custom_textfield extends StatelessWidget {
  String hinttext;
  TextInputType kyeboardtype;
  Widget icon;
  Widget? icon2;
  bool readonly;
  TextEditingController textEditingController;
  bool obscure;
  Function(String)? onPressed;


   custom_textfield({super.key,this.onPressed,this.icon2,this.obscure=false,this.readonly=false,required this.hinttext,required this.kyeboardtype,required this.icon,required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 50,

      padding: const EdgeInsets.only(left: 10),

      decoration: BoxDecoration(
        border: Border.all(color: Mycolor.border_color,width: 2,),
        borderRadius: BorderRadius.circular(10,),
        boxShadow: [
          BoxShadow(
            color: Mycolor.border_color,
            spreadRadius:0,
            blurRadius: 5,
            blurStyle: BlurStyle.outer

          )
        ]
      ),
      child: TextField(
        readOnly:readonly ,
        obscureText: obscure,
        cursorColor: Colors.black,
        controller: textEditingController,
        keyboardType: kyeboardtype,
        onChanged: onPressed,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          prefixIcon: icon,
          hintText:hinttext,
          suffixIcon: icon2,
          prefixIconColor: Mycolor.border_color,
          suffixIconColor: Mycolor.border_color,
          hintStyle: TextStyle(color: Mycolor.border_color)


        ),
      ),
    );
  }
}
