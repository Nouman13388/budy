import 'package:budy/utils/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class custom_button extends StatelessWidget {
  String title;
  VoidCallback voidCallback;

  bool visivility;
   custom_button({super.key,required this.title,required this.voidCallback,this.visivility=false, required bool visibility});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50,width: context.width,child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Mycolor.button_color,foregroundColor: Mycolor.primary_white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),onPressed:voidCallback, child:Row(
     crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        SizedBox(),
        Text(title),
        Visibility(
          visible:visivility,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Mycolor.primary_white,
              shape: BoxShape.circle,
            ),
            child:Icon(Icons.arrow_forward,color:Mycolor.button_color,size: 16,),
          ),
        )
      ],
    )));
  }
}
