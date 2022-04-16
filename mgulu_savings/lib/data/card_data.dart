import 'package:firebase_auth/firebase_auth.dart';

var currentUser = FirebaseAuth.instance.currentUser;

class CardModel {
  String groupName;
  String groupType;
  String members;
  String memberCount;
  String groupGoal;
  String groupCode;

  CardModel({
    required this.groupName,
    required this.groupType,
    required this.members,
    required this.memberCount,
    required this.groupGoal,
    required this.groupCode,
  });
}
