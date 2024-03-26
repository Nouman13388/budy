


// import 'package:budy/controller/auth_controller.dart';
// import 'package:budy/controller/event_controller.dart';
// import 'package:budy/controller/google_controller.dart';
// import 'package:budy/data/api/apiclient.dart';
// import 'package:budy/data/repository/auth_repo.dart';
// import 'package:budy/data/repository/event_repo.dart';
// import 'package:budy/utils/appconstants.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future <void> init()async
// {
//   final sharedPreferences=await SharedPreferences.getInstance();
//   Get.lazyPut(() => sharedPreferences);
//   Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: sharedPreferences));
  
//   /* ................................................repositories......................................................*/
  
//   Get.lazyPut(() => AuthRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
//   Get.lazyPut(() => EventRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));

//   /*..................................................controllers.....................................................*/

//   Get.lazyPut(() => AuthController(authRepo: Get.find()));
//   Get.lazyPut(() => googleConntroller());
//   Get.lazyPut(() => EventController(eventRepo: Get.find()));
  
  
// }