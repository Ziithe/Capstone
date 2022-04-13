import 'package:cloud_firestore/cloud_firestore.dart';

class groupsClass {
  String groupId;
  String groupName;
  String admin;
  String groupLimit;
  String groupType;
  String groupGoal;
  String frequency;
  String startDate;
  String endDate;
  List<String> members;
  Timestamp groupCreated;

  groupsClass(
      this.admin,
      this.frequency,
      this.groupCreated,
      this.groupGoal,
      this.groupId,
      this.groupLimit,
      this.groupName,
      this.groupType,
      this.startDate,
      this.endDate,
      this.members);
}
