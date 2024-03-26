import 'package:budy/utils/mycolors.dart';
import 'package:flutter/material.dart';
class custom_appbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  String? title;
  double? elevation;
  Widget? trailingicon;
  String? val;

  VoidCallback voidCallback;


  custom_appbar({super.key,this.trailingicon,this.elevation=0,this.title='',this.height=kToolbarHeight,required this.voidCallback,this.val=""});



  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      title: Text("$title"),
      centerTitle: val=="1",
      actions: [
        Container(
         child: trailingicon),
      ],
      foregroundColor: Colors.black,
      leading:val=="1"?SizedBox():InkWell(
        onTap: voidCallback,
        child: Icon(Icons.arrow_back,color: Colors.black,),
      ),
      backgroundColor: Mycolor.primary_white,
    );
  }


}
