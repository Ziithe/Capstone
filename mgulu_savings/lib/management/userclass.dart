import 'dart:ffi';

class UserClass {
  String? uid;
  String? fullname;
  String? passid;
  String? email;
  String? groupId;

  UserClass({this.email, this.fullname, this.passid, this.uid, this.groupId});

  factory UserClass.fromMap(map) {
    return UserClass(
      uid: map['uid'],
      fullname: map['fullname'],
      passid: map['passid'],
      email: map['email'],
      groupId: map['groupId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullname,
      'passid': passid,
      'email': email,
      'groupId': groupId,
    };
  }
}
