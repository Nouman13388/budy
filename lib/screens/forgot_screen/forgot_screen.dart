import 'package:budy/controller/auth_controller.dart';
import 'package:budy/utils/myfonts.dart';
import 'package:budy/utils/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/mycolors.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.primary_white,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<AuthController>(
            builder: (authController) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MyfontsSize.bigtext,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                    "Please enter your email address to request a password reset"),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'abc@gmail.com',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 50),
                authController.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          _handleForgotPassword(authController);
                        },
                        child: const Text("SEND"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleForgotPassword(AuthController authController) {
    String email = _emailController.text;

    if (email.isEmpty) {
      _showSnackBar('Please enter your email address');
    } else {
      authController.forgotPassword(email).then((value) {
        if (value == "OTP not send") {
          _showSnackBar('Something went wrong');
        } else {
          _showSnackBar('OTP sent successfully: $value');
          Get.toNamed(RouteHelper.getVerificationRoute());
        }
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

}
