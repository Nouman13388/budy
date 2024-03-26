// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:budy/model/profile_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../model/category_model.dart';

class AuthController extends GetxController implements GetxService {
  late final AuthRepo authRepo;

  AuthController({required this.authRepo}) {}

  bool _isLoading = false;

  bool get isLoading => _isLoading;




  /*......................................................Get Device Token........................................*/

  Future<String> getDeviceToken() async {

    String? _deviceToken;

    if(Platform.isIOS) {
      // _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
//vapidkey: BEpf1PFCgTziHWTU4lcRIyvQdEGxGfyonOrd7otCHELfeSD2yxj0vEkp94C9PZjCf8jM8BCqPUHLU14LzaNsoyA
      _deviceToken = await FirebaseMessaging.instance.getToken(vapidKey: "");
      print("ios==> device==>${_deviceToken}");
    }
    else {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }
    return _deviceToken!;
  }

  /*.....................................................choose categories............................................*/
  bool _finisLoad=false;
  bool get finishload=>_finisLoad;



  Future<String> chooseCategories(List<String> categoryList)  async {
    _finisLoad = true;
    update();
    String id = await authRepo.getuserid_key();
    String cat_id=categoryList.join(",");

    Map<String,String> map=
    {
      "user_id":id,
      "cat_id":cat_id
    };
    print("this is map print before api call=======${map}");
    final response = await authRepo.chooseCategories(map);
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';

    if (response.statusCode == 200) {
      result = data["result"];
    }
    _finisLoad = false;
    update();
    return result;
  }




  /*.............................................fetch categories........................................................*/

  final List<CategoryModel> _categoryModel = [];

  List<CategoryModel> get cateforyModel => _categoryModel;

  Future<String> fetchCategories() async {
    _isLoading = true;
    update();

    final response = await authRepo.fetchCategories();
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';

    if (response.statusCode == 200) {
      List<CategoryModel> categoryPage = jsonDecode(response.body)
          .map((item) => CategoryModel.fromJson(item))
          .toList()
          .cast<CategoryModel>();
      _categoryModel.clear();
      _categoryModel.addAll(categoryPage);
      print("object=============${_categoryModel}");
    }
    _isLoading = false;
    update();
    return result;
  }


  /*.............................................profile update......................................................*/

  Future<String> profileUpdate(
      String basename,
      String baseStr,
      String name1,
      String name,
      String email,
      String number,
      String password,
      String address,
      String age,
      String gender,
      String latitude,
      String longitude) async {
    _isLoading = true;
    update();
    String id = await authRepo.getuserid_key();

    Map<String, String> map = {
      "id": id,
      "username": name1,
      "full_name": name,
      "email": email,
      "contact": number,
      //"password":password,
      "address": address,
      "age": age,
      "gender": gender,
      "latitude": latitude,
      "longitude": longitude,
      "code": "+91",
      "image": basename,
      "image_str": baseStr
    };
    print('printing map before apicall=====$map');
    final response = await authRepo.updateProfile(map);
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';
    if (response.statusCode == 200) {
      // authRepo.setUserId(data["id"].toString());
      result = data["result"];
    }
    _isLoading = false;
    update();
    return result;
  }

/*.............................................login.........................................................*/

  Future<String> contactUs(String email, String subject, String message) async {
    _isLoading = true;
    update();
    print(isLoading);
    String id = await authRepo.getuserid_key();

    Map<String, String> map = {
      "id": id,
      "email": email,
      "subject": subject,
      "message": message
    };
    print('printing map before apicall=====$map');
    final response = await authRepo.contactUs(map);
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';
    if (response.statusCode == 200) {
      result = data["result"];
    }
    _isLoading = false;
    print(isLoading);
    update();
    return result;
  }

  /*.............................................fetch profile.........................................................*/

  ProfileModel? _profileModel;

  ProfileModel? get profileModel => _profileModel;

  Future<String> fetchProfile() async {
    _isLoading = true;
    update();
    print(isLoading);
    String id = await authRepo.getuserid_key();

    Map<String, String> map = {"id": id};
    print('printing map before apicall=====$map');
    final response = await authRepo.fetchProfile(map);
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';
    if (response.statusCode == 200) {
      _profileModel?.category?.clear();
      _profileModel = ProfileModel.fromJson(data);
      print("this is profile model data========${_profileModel!.fullName}");

      result = data["result"];
    }
    _isLoading = false;
    print(isLoading);
    update();
    return result;
  }

  /*.............................................set password........................................................*/

  Future<String> setPassword(String newpass, String conPass) async {
    _isLoading = true;
    update();
    String id = await authRepo.getuserid_key().toString();
    print("this is id====$id");
    Map<String, String> map = {
      "id": id,
      "new_password": newpass,
      "confirm_password": conPass
    };
    print('printing map before apicall=====$map');
    final response = await authRepo.setPassword(map);
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';

    if (response.statusCode == 200) {
      authRepo.setUserId(data["id"].toString());
      result = data["result"];
    }
    _isLoading = false;
    update();
    return result;
  }

  /*............................................forgot password................................................*/

  Future<String> forgotPassword(String email) async {
    _isLoading = true;
    update();

    Map<String, String> map = {
      "email": email,
    };
    print('printing map before apicall=====$map');
    final response = await authRepo.forgotPassword(map);
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';
    if (response.statusCode == 200) {
      if (data["result"] == "success") {
        authRepo.setUserId(data["id"].toString());
        result = data["otp"].toString();
      } else {
        result = "OTP not send";
      }
    }
    _isLoading = false;
    update();
    return result;
  }

  /*.............................................login.........................................................*/

  Future<String> login(String email, String password) async {
    _isLoading = true;
    update();
    print(isLoading);

    Map<String, String> map = {"username": email, "password": password};
    print('printing map before apicall=====$map');
    final response = await authRepo.login(map);
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';
    if (response.statusCode == 200) {
      authRepo.setUserId(data["id"].toString());
      result = data["result"];
    }
    _isLoading = false;
    print(isLoading);
    update();
    return result;
  }

  /*.............................................signup......................................................*/

  Future<String> signup(
      String name1,
      String name,
      String email,
      String number,
      String password,
      String address,
      String age,
      String gender,
      String latitude,
      String longitude,
      String type,
      String image) async {
    _isLoading = true;
    update();
    Map<String, String> map = {
      "username": name1,
      "full_name": name,
      "email": email,
      "contact": number,
      "password": password,
      "address": address,
      "age": age,
      "gender": gender,
      "latitude": latitude,
      "longitude": longitude,
      "code": "+91",
      "image":image,
      "type":type
    };
    print('printing map before apicall=====$map');
    final response = await authRepo.signup(map);
    print('printing response ===========${response.body}');
    final data = jsonDecode(response.body);
    String result = '';
    if (response.statusCode == 200) {
       authRepo.setUserId(data["id"].toString());
      result = data["result"];
    }
    _isLoading = false;
    update();
    return result;
  }
}
