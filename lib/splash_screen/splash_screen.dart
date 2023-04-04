import 'dart:async';

import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/global/globals.dart';
import 'package:drivers_app/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(Duration(seconds: 3), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/logo1.png"),
          SizedBox(height: 15),
          Text(
            "Hamraah Driver App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
