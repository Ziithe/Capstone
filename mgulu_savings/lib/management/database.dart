// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mgulu_savings/management/groupClass.dart';

// class OurDatabase {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void createGroup(String groupName, String uid) async {
//     List<String> members = [];
//     List<String> groupId = [];

//     try {
//       members.add(uid);
//       DocumentReference _docRef = await _firestore.collection("groups").add({
//         groupsClass GroupsClass = groupsClass();
//         'groupName': groupName,
//         'admin': uid,
//         'members': members,
//         'goal': groupGoal,
//         'limit': groupLimit,
//         'startOn': startDate,
//         'endOn': endDate,
//         'frequency': frequency,
//         'groupType': groupType,
//         'groupCreated': TimeStamp.now(),
//       });

//       groupId.add(groupId);
//       await _firestore.collection("users").doc(uid).update({
//         'groupId': FieldValue.arrayUnion(groupId),
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   // Future<String> joinGroup(String groupId, String uid) async {

//   // }
// }
