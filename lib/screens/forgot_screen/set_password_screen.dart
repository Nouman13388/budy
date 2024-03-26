import 'package:budy/controller/auth_controller.dart';
import 'package:budy/utils/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/mycolors.dart';
import '../../../utils/myfonts.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();

  bool _obscureNewPass = true;
  bool _obscureConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.primary_white,
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reset Password",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MyfontsSize.bigtext,
                ),
              ),
              SizedBox(height: 20),
              Text("Please Enter New Password"),
              SizedBox(height: 30),
              _buildPasswordField(
                controller: _newpassController,
                hintText: "New Password",
                obscureText: _obscureNewPass,
                onPressedVisibility: () {
                  setState(() {
                    _obscureNewPass = !_obscureNewPass;
                  });
                },
              ),
              SizedBox(height: 10),
              _buildPasswordField(
                controller: _confirmpassController,
                hintText: "Confirm Password",
                obscureText: _obscureConfirmPass,
                onPressedVisibility: () {
                  setState(() {
                    _obscureConfirmPass = !_obscureConfirmPass;
                  });
                },
              ),
              SizedBox(height: 50),
              GetBuilder<AuthController>(
                builder: (authController) => ElevatedButton(
                  onPressed: () {
                    _handleSubmit(authController);
                  },
                  child: Text("SUBMIT"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onPressedVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: onPressedVisibility,
        ),
      ),
    );
  }

  void _handleSubmit(AuthController authController) {
    String newpass = _newpassController.text;
    String confirmpass = _confirmpassController.text;

    if (newpass.isEmpty) {
      _showSnackBar('Please enter new password');
    } else if (confirmpass.isEmpty) {
      _showSnackBar('Please enter confirm password');
    } else if (newpass != confirmpass) {
      _showSnackBar('Password mismatched');
    } else {
      authController.setPassword(newpass, confirmpass).then((value) {
        if (value == "Password Reset Successfully") {
          _showSnackBar(value);
          Get.toNamed(RouteHelper.congratulation);
        } else {
          _showSnackBar(value);
        }
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
