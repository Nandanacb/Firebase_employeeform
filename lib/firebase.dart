import 'package:firebase_firebase/employeeform.dart';
import 'package:flutter/material.dart';

class FirebaseExample extends StatefulWidget {
  @override
  State<FirebaseExample> createState() => _FirebaseExampleState();
}

class _FirebaseExampleState extends State<FirebaseExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "FIREBASE FLUTTER",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Employeeform()));
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
