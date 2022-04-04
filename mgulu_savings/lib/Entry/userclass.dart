class UserClass {
  String? uid;
  String? fullname;
  String? passid;
  String? email;

  UserClass({this.email, this.fullname, this.passid, this.uid});

  factory UserClass.fromMap(map) {
    return UserClass(
      uid: map['uid'],
      fullname: map['fullname'],
      passid: map['passid'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullname,
      'passid': passid,
      'email': email,
    };
  }
}
