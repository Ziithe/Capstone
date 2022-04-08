import 'package:flutter/material.dart';

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

List<CardModel> myCards = [
  CardModel(
    groupName: "Banda Family",
    groupType: "Chipeleganyu",
    members: "Members",
    memberCount: "5/10",
    groupGoal: "MWK 25,000",
    groupCode: "JOIN56z28Y",
  ),
  CardModel(
    groupName: "Banda Family",
    groupType: "Chipeleganyu",
    members: "Members",
    memberCount: "5/10",
    groupGoal: "MWK 25,000",
    groupCode: "JOIN56z28Y",
  ),
];
