import 'package:budy/firebase_options.dart';
import 'package:budy/utils/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app with a splash screen delay
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Convert GetPage list to a Map
    final Map<String, Widget Function(BuildContext)> routesMap = {
      for (var page in RouteHelper.routes)
        (page).name: (BuildContext context) => (page).page()
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budy',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: RouteHelper.getSplashRoute(), // Set initial route here
      routes: routesMap, // Use converted routes map here
    );
  }
}
