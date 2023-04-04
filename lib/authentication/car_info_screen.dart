import 'package:drivers_app/splash_screen/splash_screen.dart';
import 'package:drivers_app/widgets/custom_msg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../global/globals.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  TextEditingController carColorController = TextEditingController();
  List<String> carTypes = ["uber-x", "uber-go", "bike"];
  String? selectCarType;

  saveCarInfo() async {
    Map driverCarMap = {
      "car_color": carColorController.text,
      "car_number": carNumberController.text,
      "car_model": carModelController.text,
      "type": selectCarType,
    };
    DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers");
    driverRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarMap);
    Navigator.push(context, MaterialPageRoute(builder: (_) => MySplashScreen()));
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
                "Enter Car Details",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: carModelController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "car Model",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "car Model",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: carNumberController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "Car Number",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "Car Number",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: carColorController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "Car Color",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "Car Color",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              DropdownButton(
                hint: Text(
                  "Please Choose Car Type",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                items: carTypes.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (v) {
                  setState(() {
                    selectCarType = v.toString();
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  onPressed: () {
                    if (carColorController.text.isNotEmpty &&
                        carNumberController.text.isNotEmpty &&
                        carModelController.text.isNotEmpty &&
                        selectCarType != null) {
                      saveCarInfo();
                    } else {
                      showCustomMsg(context, "Please Fill All Field");
                    }
                  },
                  child: Text(
                    "Save Now",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
