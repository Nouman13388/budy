import 'package:budy/utils/route_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ScreenState { Forgot, Congratulation, SetPassword, Verification }

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  ScreenState _currentState = ScreenState.Forgot;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  late String _verificationId;

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
      case ScreenState.SetPassword:
        return _buildSetPasswordScreen();
      case ScreenState.Verification:
        return _buildVerificationScreen();
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
          const Text(
            "Congratulations",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          const Text("Forgot Password Successfully"),
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

  Widget _buildSetPasswordScreen() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Reset Password",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          const Text("Please Enter New Password"),
          const SizedBox(height: 30),
          TextField(
            controller: _newpassController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "New Password",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _confirmpassController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Confirm Password",
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              _resetPassword(_newpassController.text, context);
            },
            child: const Text("SUBMIT"),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationScreen() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Verification",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          const Text("We’ve send you the verification code"),
          const SizedBox(height: 30),
          _buildOTPTextField(),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: _submitOTP,
            child: const Text("Continue"),
          ),
          const SizedBox(height: 50),
          Center(
            child: RichText(
              text: const TextSpan(
                text: "Re-send code in  ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "0.20",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 4; i++)
          SizedBox(
            width: 50,
            child: TextField(
              controller: _pinController,
              maxLength: 1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                counter: Offstage(),
              ),
            ),
          ),
      ],
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
