import 'package:budy/utils/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  final String? otp;

  const VerificationScreen({Key? key, this.otp}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(3, (index) => FocusNode());

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void _nextField(int index) {
    if (index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else {
      _focusNodes[index].unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Verification"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We've sent you the verification code",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: MediaQuery.of(context).size.width / 7 + 20,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index < 3 ? index : 2],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      onChanged: (value) => _nextField(index),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        counterText: '',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  final enteredOtp =
                      _controllers.map((controller) => controller.text).join();
                  if (enteredOtp == widget.otp) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('OTP verified successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Get.toNamed(RouteHelper.setpassword);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter correct OTP'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text("Continue"),
              ),
              SizedBox(height: 50),
              Center(
                child: RichText(
                  text: TextSpan(
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
        ),
      ),
    );
  }
}
