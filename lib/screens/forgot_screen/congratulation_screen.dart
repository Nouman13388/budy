import 'package:budy/screens/signin_screen.dart';
import 'package:budy/utils/myfonts.dart';
import 'package:budy/utils/myimages.dart';
import 'package:budy/utils/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/mycolors.dart';
import '../../base/custom_appbar.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolor.primary_white,
      appBar: AppBar(
        title: Text('Congratulations'),
        backgroundColor: Mycolor.primary_color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(MyImages.congrateimg, height: 300),
                ),
                SizedBox(height: 10),
                Text(
                  "Congratulations",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MyfontsSize.bigtext,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Forgot Password Successfully",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(RouteHelper.getSigninRoute());
                  },
                  child: Text("Go To Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
