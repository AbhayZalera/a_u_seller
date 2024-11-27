import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:a_u_seller/views/auth_screen/login_screen.dart';
import 'package:a_u_seller/views/home_screen/home.dart'; // Import your home screen
import 'const/const.dart'; // Import constants like appname
import 'const/firebase_consts.dart'; // Import firebase constants

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC1GpAEqSqYJXye00wSXP5JYTlYV74mAeg',
        appId: '1:612433370097:android:8e3d77fa9e4e74e10f0250',
        messagingSenderId: '612433370097',
        projectId: "austore-4ffc3",
        storageBucket: 'austore-4ffc3.appspot.com',
      ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variable to track if the user is logged in
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    checkUser();  // Check user login status when app initializes
  }

  // Function to check if a user is already logged in
  void checkUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // If no user is logged in, set isLogin to false
        setState(() {
          isLogin = false;
        });
      } else {
        // If a user is logged in, set isLogin to true
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname, // App name from constants
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      // Navigate to the home screen if user is logged in, otherwise show the login screen
      home: isLogin ? const Home() : const LoginScreen(),
    );
  }
}
