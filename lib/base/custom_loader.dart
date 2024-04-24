

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/mycolors.dart';

Widget custom_loader()
{
  return Center(child:CircularProgressIndicator(semanticsValue: "loader",backgroundColor: Colors.pink.shade50,color: Mycolor.primary_color,strokeWidth: 2,
  ));
}


