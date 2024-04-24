



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/mycolors.dart';
import '../../utils/myimages.dart';


class Shimmers
{

  static  Widget event_details_shimmer(BuildContext context){
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor:Color(0xa1f1615e),

        child: Padding(
            padding: const EdgeInsets.all( 10.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 30,),
                Center(
                  child: Container(
                    height: 10,
                    width: 80,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                    margin: EdgeInsets.all(3),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  height: 9,
                  width: 350,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 7,
                  width: 300,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 5,
                  width: 250,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 3,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 50,),
                Container(
                  height: 9,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 7,
                  width: 150,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 3,
                  width: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 30,),
                Container(
                  height: 9,

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
                SizedBox(height: 40,),
                Container(
                  height: 40,

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                ),
              ],
            )
        )
    );
  }



  static  Widget saved_address_shimmer(BuildContext context){
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor:Color(0xa1f1615e),

        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(

            minVerticalPadding: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Mycolor.border_color,width: 2)),
            leading: Image.asset(MyImages.address_icon),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 9,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                  width: 150,),
                SizedBox(height: 5,),
                Container(height: 7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                  width: 100,),
                SizedBox(height: 5,),
              ],
            ),
            trailing:  Icon(CupertinoIcons.location_fill),
          ),
        ),
    );
  }


  static  Widget custom_suscrcption_shimmer(BuildContext context){
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor:Color(0xa1f1615e),

        child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child:ListTile(

              minVerticalPadding: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Mycolor.border_color,width: 2)),
              leading: Image.asset(MyImages.budy_logo),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 9,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                    margin: EdgeInsets.all(3),
                    width: 150,),
                  SizedBox(height: 5,),
                  Container(height: 7,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                    margin: EdgeInsets.all(3),
                    width: 100,),
                  SizedBox(height: 5,),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                    margin: EdgeInsets.all(3),

                  ),
                  SizedBox(height: 5,),



                ],
              ),
              trailing:   Container(height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Mycolor.border_color,),
                margin: EdgeInsets.all(3),
                width: 80,) ,
            ),
        )
    );
  }
  static  Widget custom_upcoming_shimmer(BuildContext context){
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor:Color(0xa1f1615e),

        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child:Container(
            width: 250,
            height: context.height/3,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2,color: Mycolor.border_color)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(height: 130,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                margin: EdgeInsets.all(3),
              ),
                Container(height: 11,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                  width: 250,),
                Container(height: 9,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                  width: 200,),
                Container(height: 7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                  width: 150,),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),

                ),

              ],
            ),
          )
        )
    );
  }


   static  Widget customshimmer()
  {
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor:Color(0xa1f1615e),

        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ListTile(

            minVerticalPadding: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Mycolor.border_color,width: 2)),
            leading: Image.asset(MyImages.budy_logo),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 11,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                  width: 250,),
                Container(height: 9,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                  width: 200,),
                Container(height: 7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),
                  width: 150,),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Mycolor.border_color,),
                  margin: EdgeInsets.all(3),

                ),



              ],
            ),
          ),
        )
    );
  }
}

