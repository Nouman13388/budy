import 'package:budy/utils/myfonts.dart';
import 'package:flutter/material.dart';
class distance_select_dialogue extends StatefulWidget {
  const distance_select_dialogue({super.key});

  @override
  State<distance_select_dialogue> createState() => _distance_select_dialogueState();
}

class _distance_select_dialogueState extends State<distance_select_dialogue> {
  double val=0;

  @override
  Widget build(BuildContext context) {
    return

      SliderTheme(data: SliderThemeData(
        //https://blog.logrocket.com/flutter-slider-widgets-deep-dive-with-examples/
      ), child: Slider(divisions: 10,label: "$val KM",secondaryActiveColor: Colors.blue,secondaryTrackValue: 10,min: 0,max: 100,activeColor: Colors.green,inactiveColor: Colors.red,thumbColor: Colors.yellow,mouseCursor: MaterialStateMouseCursor.clickable,value: val, onChangeEnd: (value2){
        setState(() {
          val=value2;
          print("prinf tha value=end===$val");
        });
      },onChangeStart: (value1){

        setState(() {
          val=value1;
          print("prinf tha value=start===$val");

        });
      },onChanged: (value){
        setState(() {

          val=value;
          print("prinf tha value=onchnge===$val");

        });
      }));




  }
  Future  showDialohuebox()async{
    showGeneralDialog(context: context, pageBuilder: (context,anim,anim1)=>Card(
      child: Column(
        children: [
          Text("Select Distance",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MyfontsSize.mediumtext),)
        ],
      ),
    ));
  }
}
