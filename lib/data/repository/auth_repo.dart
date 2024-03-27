// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:budy/utils/appconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/apiclient.dart';
import 'package:http/http.dart' as Http;

class AuthRepo {
  late final ApiClient apiClient;
  late final SharedPreferences sharedPreferences;

  AuthRepo({required this.sharedPreferences, required this.apiClient});



  //..........................................Updated device android and ios token.............................//

  // ignore: no_leading_underscores_for_local_identifiers
  Future<Http.Response?> updateToken(String _deviceToken) async {
    String id = await getuserid_key();
    print("userId======$id ,device token==>$_deviceToken");
    try {

      late final response;
      if(Platform.isIOS){

        response= await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.IOSTOKENS),
          body: {

            "user_id":id,
            "device_id":_deviceToken,
            "device_status":"IOS"

          },
        ).timeout(const Duration(seconds: AppConstants.timeoutInSeconds));

      }
      else
      {
        response= await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.ANDROIDTOKEN),
          body: {
            "user_id":id,
            "device_id":_deviceToken,
            "device_status":"Android"

          },
        ).timeout(const Duration(seconds: AppConstants.timeoutInSeconds));
      }
      return response;
    }
    catch (e) {
      print("Exceptioon update token==>$e");
      //return null!;
    }
    return null;
  }



  /*...............................................choosed categories.......................................................*/

  Future<Http.Response> chooseCategories(Map<String,String> map) async {
    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.CHOOSECATEGORY),body: map)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));
  }






  /*...............................................fetch categories.......................................................*/

  Future<Http.Response> fetchCategories() async {
    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.FETCHCATEGORY),)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));
  }


  /*...............................................update profile.......................................................*/

  Future<Http.Response> updateProfile(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.UPDATEPROFILE), body:map)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));

  }



  /*...............................................contact us.......................................................*/

  Future<Http.Response> contactUs(Map<String,String> map) async {
    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.CONTACTUS), body:map)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));
  }


  /*...............................................fetch profile.......................................................*/

  Future<Http.Response> fetchProfile(Map<String,String> map) async {
    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.FETCHPROFILE), body:map)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));
  }




  /*...............................................setpassword.......................................................*/

  Future<Http.Response> setPassword(Map<String,String> map) async {
    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.SETPASS), body:map)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));
  }






  /*...............................................fogotpassword.......................................................*/

  Future<Http.Response> forgotPassword(Map<String,String> map) async {
    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.SENDOTP), body:map)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));
  }


  /*...............................................login.......................................................*/

  Future<Http.Response> login(Map<String,String> map) async {
    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.LOGIN), body:map)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));
  }



  /*...............................................singup.......................................................*/

  Future<Http.Response> signup(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.SIGNUP), body:map)
        .timeout(const Duration(seconds: AppConstants.timeoutInSeconds));

  }


/*...................................................sharedpreference.............................................*/

  bool getOnbording_key() {
    return sharedPreferences.getBool(AppConstants.onBoarding) ?? false;
  }

  String getuserid_key() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  String getloginid_key() {
    return sharedPreferences.getString(AppConstants.loginId) ?? "";
  }

  Future<void>  setloginId(String value)async{
    try{
      await sharedPreferences.setString(AppConstants.loginId, value);
    }
    catch(e)
    {
      rethrow;
    }
  }


  Future<void>  setUserId(String value)async{
    try{
     await sharedPreferences.setString(AppConstants.userId, value);
    }
        catch(e)
    {
      rethrow;
    }
  }

  Future<void> setOnboarding_key(bool onboardingkey) async {
    try {
      await sharedPreferences.setBool(AppConstants.onBoarding, onboardingkey);

    } catch (e) {
      rethrow;
    }

  }

  void clearSharedPreference() async{


    await sharedPreferences.clear();
  }

}
