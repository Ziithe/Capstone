import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Get user data

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('users');

Future<void> getData() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
}
