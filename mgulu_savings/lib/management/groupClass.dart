import 'dart:ffi';

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
  List<dynamic> members;

  groupsClass(
      this.groupId,
      this.groupName,
      this.admin,
      this.groupLimit,
      this.groupType,
      this.groupGoal,
      this.frequency,
      this.startDate,
      this.endDate,
      this.members);
}
