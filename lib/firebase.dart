import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firebase/database.dart';
import 'package:firebase_firebase/employeeform.dart';
import 'package:flutter/material.dart';

class FirebaseExample extends StatefulWidget {
  @override
  State<FirebaseExample> createState() => _FirebaseExampleState();
}

class _FirebaseExampleState extends State<FirebaseExample> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  Stream<QuerySnapshot>? EmployeeStream;

  getontheload() async {
    EmployeeStream = await Database.getEmloyeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder<QuerySnapshot>(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error:${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No employee data available.'),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Container(
                  
                  margin: EdgeInsets.all(20),
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Name:" + (ds['Name'] ?? 'N/A'),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Age:" + (ds['Age'] ?? 'N/A').toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "Location" + (ds['Location'] ?? 'N/A'),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                );
              });
        });
  }

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
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Expanded(child: allEmployeeDetails()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Employeeform()));
          },
          child: Icon(Icons.add),
        ));
  }
}
