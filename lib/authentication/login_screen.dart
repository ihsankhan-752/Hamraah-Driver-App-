import 'package:drivers_app/authentication/signup_screen.dart';
import 'package:drivers_app/splash_screen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../global/globals.dart';
import '../widgets/custom_msg.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  validateForm() {
    if (emailController.text.length < 3) {
      showCustomMsg(context, "Email is Required");
    } else if (passwordController.text.length < 6) {
      showCustomMsg(context, "Password is Required");
    } else {
      loginDriver();
    }
  }

  loginDriver() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return ProgressDialog(message: "Processing Please Wait");
        });

    final user = await fAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).catchError((e) {
      Navigator.pop(context);
      showCustomMsg(context, e.toString());
    });
    if (user.user != null) {
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(user.user!.uid).once().then((driverKey) {
        final snapshot = driverKey.snapshot;
        if (snapshot.value != null) {
          currentFirebaseUser = user.user;
          Navigator.push(context, MaterialPageRoute(builder: (_) => MySplashScreen()));
        } else {
          showCustomMsg(context, "No Record Exist");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (_) => MySplashScreen()));
        }
      });
    } else {
      Navigator.pop(context);
      showCustomMsg(context, "Error Occurred During Login!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("images/logo1.png"),
              ),
              SizedBox(height: 10),
              Text(
                "Login as a Driver",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: emailController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "email",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "password",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  onPressed: () {
                    loginDriver();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
                child: Text("Don't have an Account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
