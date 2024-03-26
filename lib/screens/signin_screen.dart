import 'package:budy/screens/forgot_screen.dart';
import 'package:budy/screens/home_screen.dart';
import 'package:budy/screens/signup_screen.dart';
import 'package:budy/utils/route_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Track loading state
  bool _rememberMe = false; // Track remember me checkbox state
  late SharedPreferences _prefs; // Shared preferences instance

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  // Initialize shared preferences instance
  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // Load remember me preference and set email and password if available
    setState(() {
      _rememberMe = _prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _emailController.text = _prefs.getString('email') ?? '';
        _passwordController.text = _prefs.getString('password') ?? '';
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/budy_logo.png', // Path to your image asset
                width: 150, // Adjust the width as needed
                height: 150, // Adjust the height as needed
              ),
              const SizedBox(height: 20), // Add some spacing
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        const Text('Remember Me'),
                        Expanded(child: Container()), // Spacer
                        TextButton(
                          onPressed: () {
                            // Navigate to the forgot password screen using named route
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotScreen()),
                            );
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async => await _signInWithEmailAndPassword(),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Sign In'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async => await _signInWithGoogle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.png', // Path to your image asset
                            width: 24, // Adjust the width as needed
                            height: 24, // Adjust the height as needed
                          ),
                          const SizedBox(
                              width:
                                  10), // Add some spacing between icon and text
                          const Text('Sign In with Google'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text('Don\'t have an account? Sign Up'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    // Set loading state to true
    setState(() {
      _isLoading = true;
    });

    // Sign in with email and password
    try {
      await Future.delayed(
          const Duration(seconds: 2)); // Simulate network delay

      // Your sign-in logic goes here

      // Save email and password if remember me is checked
      if (_rememberMe) {
        _prefs.setBool('rememberMe', true);
        _prefs.setString('email', _emailController.text.trim());
        _prefs.setString('password', _passwordController.text);
      } else {
        _prefs.remove('rememberMe');
        _prefs.remove('email');
        _prefs.remove('password');
      }

      // Navigate to the home screen after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (error) {
      // Handle sign-in errors
      if (kDebugMode) {
        print("Error signing in: $error");
      }
    } finally {
      // Set loading state to false when sign-in process is complete
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      // Set loading state to true
      setState(() {
        _isLoading = true;
      });

      // Initialize Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            '523373871783-mg8bntvgil3vvnl2lvar3re38p7miqkf.apps.googleusercontent.com',
      );
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        await FirebaseAuth.instance.signInWithCredential(credential);

        // Navigate to the home screen after successful sign-in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (error) {
      // Handle Google sign-in errors
      String errorMessage = 'An error occurred. Please try again later.';

      // Show error message to the user using a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );

      if (kDebugMode) {
        print("Error signing in with Google: $error");
      }

      // Set loading state to false
      setState(() {
        _isLoading = false;
      });
    }
  }
}
