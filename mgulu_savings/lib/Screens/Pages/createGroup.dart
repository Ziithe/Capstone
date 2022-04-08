import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool _hiddenPass = true;

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
    'Savings and Loan Group (Gulu)',
    'Rotational Savings Group (Chipeleganyu)',
  ];

  String? groupType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(color: primaryColor),
            title: Image.asset("assets/Images/WBG_Icon.png",
                fit: BoxFit.contain, height: 26.0, width: 26.0),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Open Settings',
                  onPressed: () {}),
            ]),
        body: SafeArea(
            child: SizedBox(
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(height: screenHeight(context) * 0.03),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Create Group",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight(context) * 0.03),
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Group Name",
                                  style: const TextStyle(
                                      fontSize: 18,
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
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: textColor),
                                ),
                                const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 0)),
                                DropdownButtonFormField(
                                  items: groupTypes.map(buildMenuItem).toList(),
                                  onChanged: (value) => setState(
                                      () => this.groupType = groupType),
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
                                          "Log In",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                            ),
                          ]),
                        ),
                      )
                    ]))))));
  }

  DropdownMenuItem<String> buildMenuItem(String groupType) => DropdownMenuItem(
        value: groupType,
        child: Text(
          groupType,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  void _passwordVisible() {
    setState(() {
      _hiddenPass = !_hiddenPass;
    });
  }
}
