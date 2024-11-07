import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_firebase/database.dart'; // Your Database class

class Employeeform extends StatefulWidget {
  @override
  State<Employeeform> createState() => _EmployeeformState();
}

class _EmployeeformState extends State<Employeeform> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Employee details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text("Name"),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 30),
              Text("Age"),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  controller: ageController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 30),
              Text("Location"),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () async {
                    String id = randomAlphaNumeric(10);
                    Map<String, dynamic> employeeInfoMap = {
                      "Name": nameController.text,
                      "Age": ageController.text,
                      "Id": id,
                      "Location": locationController.text,
                    };

                    try {
                      await Database.addEmployeeDetails(employeeInfoMap, id);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Employee details added successfully"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  nameController.clear();
                                  ageController.clear();
                                  locationController.clear();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(
                                "Failed to add employee details. Please try again later."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text("Add")),
            ],
          ),
        ),
      ),
    );
  }
}
