import 'package:budy/screens/signin_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Budy',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const SignInScreen(),
  ));
}
