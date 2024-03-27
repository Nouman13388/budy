// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:budy/utils/route_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum ScreenState { Forgot, Congratulation, SetPassword, Verification }

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  ScreenState _currentState = ScreenState.Forgot;
  final TextEditingController _emailController = TextEditingController();
  // ignore: unused_field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentState == ScreenState.Forgot
            ? 'Forgot Password'
            : _currentState == ScreenState.Congratulation
                ? 'Congratulations'
                : _currentState == ScreenState.SetPassword
                    ? 'Set Password'
                    : 'Verification'),
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    switch (_currentState) {
      case ScreenState.Forgot:
        return _buildForgotScreen();
      case ScreenState.Congratulation:
        return _buildCongratulationScreen();
      default:
        return Container();
    }
  }

  Widget _buildForgotScreen() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Please enter your email address to request a password reset",
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: "Enter your email",
              labelText: "Email",
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              _forgotPassword(_emailController.text, context);
            },
            child: const Text("SEND"),
          ),
        ],
      ),
    );
  }

  Widget _buildCongratulationScreen() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
              "An email has been sent to your email address, please check your inbox"),
          const SizedBox(height: 70),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteHelper.getSigninRoute());
            },
            child: const Text("Go To Login"),
          ),
        ],
      ),
    );
  }

  void _forgotPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        _currentState = ScreenState.Congratulation;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error sending password reset email: $e');
      }
      // Display error message using a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending password reset email: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _resetPassword(String newPassword, BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        setState(() {
          _currentState = ScreenState.Verification;
        });
      } else {
        if (kDebugMode) {
          print('User not logged in');
        }
        // Display error message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not logged in'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error resetting password: $e');
      }
      // Display error message using a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error resetting password: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _submitOTP() async {
    try {
      // Implement your OTP submission logic here
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting OTP: $e');
      }
      // Display error message using a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting OTP: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
