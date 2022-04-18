import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mgulu_savings/Screens/home.dart';

import '../../constants/constants.dart';
import '../../constants/size.dart';

class joinGroup extends StatefulWidget {
  final String? uid;
  const joinGroup({Key? key, this.uid}) : super(key: key);

  @override
  State<joinGroup> createState() => _joinGroupState();
}

class _joinGroupState extends State<joinGroup> {
  final _formKey = GlobalKey<FormState>();
  final groupIdController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    groupIdController;
    super.dispose();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: primaryColor),
          title: Text(
            "Join Group",
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              tooltip: 'Back',
              onPressed: () {
                Navigator.pop(context, true);
              }),
        ),
        body: SafeArea(
            child: SizedBox(
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(height: screenHeight(context) * 0.03),
                      Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Group ID",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0)),
                              TextFormField(
                                controller: groupIdController,
                                obscureText: false,
                                cursorColor: textColor,
                                textInputAction: TextInputAction.next,
                                validator: (String? stringValue) {
                                  if (stringValue != null &&
                                      stringValue.isEmpty) {
                                    return "Group ID is a required field, please enter it here";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    filled: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight(context) * 0.04),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 0,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    width: double.infinity,
                                    height: screenHeight(context) * 0.06,
                                    child: MaterialButton(
                                      color: primaryColor,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 20.0),
                                      child: const Text(
                                        "Join Group",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            joinGroup(groupIdController.text,
                                                user.uid);
                                          } catch (e) {
                                            throw Error();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                          ),
                        ]),
                      )
                    ]))))));
  }

  void joinGroup(String groupId, String uid) async {
    DocumentSnapshot groupData = await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupIdController.text)
        .get();

    List<String> members = [];

    try {
      members.add(uid);
      await _firestore.collection("groups").doc(groupIdController.text).update({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore.collection("users").doc(uid).collection("myGroups").add({
        'groupId': groupIdController.text,
        'groupName': groupData.get('groupName'),
        'admin': groupData.get('admin'),
        'members': groupData.get("members"),
        'goal': groupData.get('goal'),
        'limit': groupData.get('limit'),
        'startOn': groupData.get('startOn'),
        'endOn': groupData.get('endOn'),
        "activeBalance": groupData.get('activeBalance'),
        'frequency': groupData.get('frequency'),
        'groupType': groupData.get('groupType'),
        'createdOn': groupData.get('createdOn'),
      });
      await _firestore.collection("users").doc(uid).collection("Activity").add({
        'comment': 'Success',
        'details': 'Joined Group - ' + groupData.get('groupName'),
        'date': Timestamp.now(),
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AlertDialog(
                    title: Text("Joined Group Successfully"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        uid: uid,
                                      ))),
                          child: Text("Return to Home"))
                    ],
                  )));
    } catch (e) {
      print(e);
    }
  }
}
