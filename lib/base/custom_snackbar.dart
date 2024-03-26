import 'package:budy/utils/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomSnakeBar(BuildContext context, String title) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "$title",
      style: TextStyle(color: Mycolor.primary_white),
    ),
    duration: Duration(seconds: 2),
    dismissDirection: DismissDirection.startToEnd,

    backgroundColor: Mycolor.primary_color,
  ));
}
