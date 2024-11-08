import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database {
  static Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  static Future<Stream<QuerySnapshot>> getEmloyeeDetails() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }
}
