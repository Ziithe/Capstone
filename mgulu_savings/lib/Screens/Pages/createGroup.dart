import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mgulu_savings/Screens/home.dart';

import '../../constants/constants.dart';
import '../../constants/size.dart';

class createGroup extends StatefulWidget {
  final String? uid;
  const createGroup({Key? key, this.uid}) : super(key: key);

  @override
  State<createGroup> createState() => _createGroupState();
}

class _createGroupState extends State<createGroup> {
  final _formKey = GlobalKey<FormState>();
  final groupNameController = TextEditingController();
  final groupTypeController = TextEditingController();
  final groupGoalController = TextEditingController();
  final goalFrqController = TextEditingController();
  final groupLimitController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    groupGoalController;
    groupNameController;
    groupTypeController;
    groupLimitController;
    goalFrqController;
    startDateController;
    endDateController;
    super.dispose();
  }

  final groupTypes = [
    'Savings and Loan Group',
    'Rotational Savings Group',
  ];

  final frequencies = ['Daily', 'Weekly', 'Monthly'];

  String? groupType;

  String? frq;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: textColor),
          title: Text(
            "Create Group",
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
                                "Group Name",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0)),
                              TextFormField(
                                controller: groupNameController,
                                obscureText: false,
                                cursorColor: textColor,
                                textInputAction: TextInputAction.next,
                                validator: (String? stringValue) {
                                  if (stringValue != null &&
                                      stringValue.isEmpty) {
                                    return "Group Name is a required field, please enter it here";
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
                          SizedBox(height: screenHeight(context) * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Group Type",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0)),
                              DropdownButtonFormField(
                                  value: groupType,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      filled: true,
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      )),
                                  isExpanded: true,
                                  items: groupTypes.map(buildMenuItem).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      groupType = newValue;
                                    });
                                  }),
                            ],
                          ),
                          SizedBox(height: screenHeight(context) * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Please set your Savings Goal",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0)),
                              TextFormField(
                                controller: groupGoalController,
                                obscureText: false,
                                cursorColor: textColor,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                    name: 'RWF',
                                  )
                                ],
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                validator: (String? stringValue) {
                                  if (stringValue != null &&
                                      stringValue.isEmpty) {
                                    return "Goal cannot be empty";
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
                          SizedBox(height: screenHeight(context) * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contribution Frequency",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0)),
                              DropdownButtonFormField(
                                  value: frq,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      filled: true,
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      )),
                                  isExpanded: true,
                                  items:
                                      frequencies.map(buildMenuItem).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      frq = newValue;
                                    });
                                  }),
                            ],
                          ),
                          SizedBox(height: screenHeight(context) * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Please set a Group Limit",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0)),
                              TextFormField(
                                controller: groupLimitController,
                                obscureText: false,
                                cursorColor: textColor,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                validator: (String? stringValue) {
                                  if (stringValue != null &&
                                      stringValue.isEmpty) {
                                    return "Please set a valid group limit";
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
                          SizedBox(height: screenHeight(context) * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start On",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0)),
                              DateTimePicker(
                                type: DateTimePickerType.date,
                                dateMask: "d MMMM, yyyy",
                                controller: startDateController,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                                validator: (String? stringValue) {
                                  if (stringValue != null &&
                                      stringValue.isEmpty) {
                                    return "Please enter start date";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    filled: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    )),
                              )
                            ],
                          ),
                          SizedBox(height: screenHeight(context) * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "End On",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0)),
                              DateTimePicker(
                                type: DateTimePickerType.date,
                                dateMask: "d MMMM, yyyy",
                                controller: endDateController,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                                validator: (String? stringValue) {
                                  if (stringValue != null &&
                                      stringValue.isEmpty) {
                                    return "Please enter end date";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    filled: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    )),
                              )
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
                                        "Create Group",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          createGroup(groupNameController.text,
                                              user.uid);
                                        }
                                      },
                                    ),
                                  ),
                          ),
                        ]),
                      )
                    ]))))));
  }

  DropdownMenuItem<String> buildMenuItem(String groupType) => DropdownMenuItem(
        value: groupType,
        child: Text(
          groupType,
          style: TextStyle(
              fontWeight: FontWeight.w400, color: textColor, fontSize: 15),
        ),
      );

  void createGroup(String groupName, String uid) async {
    List<String> members = [];

    try {
      members.add(uid);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'groupName': groupNameController.text,
        'admin': uid,
        'members': members,
        'goal': groupGoalController.text,
        'limit': groupLimitController.text,
        'startOn': startDateController.text,
        'endOn': endDateController.text,
        'frequency': frq.toString(),
        'groupType': groupType.toString(),
        'groupCreated': Timestamp.now(),
      });

      await _firestore.collection("users").doc(uid).collection("myGroups").add({
        'groupId': _docRef.id,
        'groupName': groupNameController.text,
        'admin': uid,
        'members': members,
        'goal': groupGoalController.text,
        'limit': groupLimitController.text,
        'startOn': startDateController.text,
        'endOn': endDateController.text,
        'frequency': frq.toString(),
        'groupType': groupType.toString(),
        'groupCreated': Timestamp.now(),
      });

      await _firestore.collection("users").doc(uid).collection("Activity").add({
        'comment': 'Success',
        'details': 'Created Group - ' + groupNameController.text,
        'date': Timestamp.now(),
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AlertDialog(
                    title: Text("Group Created Successfully!"),
                    content: Text(
                        "Copy and Share the code to invite friends to your group"),
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
