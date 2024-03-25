  import 'package:budy/add_card.dart';
import 'package:budy/paypal_screen.dart';
import 'package:budy/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

  import 'google_maps.dart';

  void main() {
    OnePlatform.app = () => const MyApp();
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return OneNotification(
        builder:(_,__)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:  PayPal(),
          builder: OneContext().builder,
          navigatorKey: OneContext().key,
        ),
      );
    }
  }
