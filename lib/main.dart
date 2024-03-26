import 'package:budy/firebase_options.dart';
import 'package:budy/screens/forgot_screen/forgot_screen.dart';
import 'package:budy/screens/splash_screen.dart';
import 'package:budy/utils/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app with a splash screen delay
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert GetPage list to a Map
    final Map<String, Widget Function(BuildContext)> routesMap =
        Map.fromIterable(
      RouteHelper.routes,
      key: (page) => (page as GetPage).name,
      value: (page) => (BuildContext context) => (page as GetPage).page(),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteHelper.getSplashRoute(), // Set initial route here
      routes: routesMap, // Use converted routes map here
    );
  }
}
