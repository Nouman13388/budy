import 'package:budy/screens/budy_screen.dart';
import 'package:budy/screens/event_screen.dart';
import 'package:budy/screens/explore_screen.dart';
import 'package:budy/screens/forgot_screen.dart';
import 'package:budy/screens/home_screen.dart';
import 'package:budy/screens/onboarding_screen.dart';
import 'package:budy/screens/profile_screen.dart';
import 'package:budy/screens/saved_screen.dart';
import 'package:budy/screens/setting_screen.dart';
import 'package:budy/screens/signin_screen.dart';
import 'package:budy/screens/signup_screen.dart';
import 'package:budy/screens/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String onboarding = "/onboarding";
  static const String signin = "/signin";
  static const String signup = "/signup";
  static const String forgot = "/forgot";
  static const String verification = "/verification";
  static const String setpassword = "/setpassword";
  static const String congratulation = "/congratulation";
  static const String home = "/home";
  static const String explore = "/explore";
  static const String event = "/event";
  static const String profile = "/profile";
  static const String saved = "/saved";
  static const String setting = "/setting";
  static const String buddy = "/buddy";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getOnboardingRoute() => onboarding;
  static String getSigninRoute() => signin;
  static String getSignupRoute() => signup;
  static String getForgotRoute() => forgot;
  static String getVerificationRoute() => verification;
  static String getSetPasswordRoute() => setpassword;
  static String getCongratulationRoute() => congratulation;
  static String getHomeRoute() => home;
  static String getExploreRoute() => explore;
  static String getEventRoute() => event;
  static String getProfileRoute() => profile;
  static String getSavedRoute() => saved;
  static String getSettingRoute() => setting;
  static String getBuddyRoute() => buddy;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signin, page: () => const SignInScreen()),
    GetPage(name: signup, page: () => const SignUpScreen()),
    GetPage(name: forgot, page: () => const ForgotScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: explore, page: () => const ExploreScreen()),
    GetPage(name: event, page: () => const EventScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: saved, page: () => const SavedScreen()),
    GetPage(name: setting, page: () => const SettingsScreen()),
    GetPage(name: buddy, page: () => const BudyScreen()),
  ];
}
