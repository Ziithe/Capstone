import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/createGroup.dart';

import '../../constants/constants.dart';
import '../../constants/size.dart';

class GroupPage extends StatefulWidget {
  final String? uid;
  const GroupPage({Key? key, this.uid}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  var currentUser = FirebaseAuth.instance.currentUser;

  Future getUserGroupStat() async {
    var currentUser = await FirebaseAuth.instance.currentUser;
    var firebaseUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Oops, something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            var groupStatus = Text('${data['groupId']}');
            if (groupStatus != null) {
              return Container(
                child: SizedBox(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: screenHeight(context) * 0.1),
                          SizedBox(
                            child: Column(
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/Images/noGroups.svg",
                                  height: screenHeight(context) * 0.2,
                                ),
                                SizedBox(
                                  child: Column(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      Text(
                                        "Hmm.. Seems you’re not in any groups yet :(",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.workSans(
                                            color: textColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: .2),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16,
                                            left: 12,
                                            right: 12,
                                            bottom: 16),
                                        child: Text(
                                          "Click below to start saving now",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.workSans(
                                              color: textSecondary,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: .2),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight(context) * 0.05),
                                SizedBox(
                                  child: Column(
                                    children: <Widget>[
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                  screenWidth(context),
                                                  screenHeight(context) * 0.06),
                                              primary: primaryColor,
                                              onPrimary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {},
                                          child: Text(
                                            "Join a Group",
                                            style: GoogleFonts.workSans(
                                              // ignore: prefer_const_constructors
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: .2),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight(context) * 0.03),
                                SizedBox(
                                  child: Column(
                                    children: <Widget>[
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                  screenWidth(context),
                                                  screenHeight(context) * 0.06),
                                              primary: secondaryColor,
                                              onPrimary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        createGroup()));
                                          },
                                          child: Text(
                                            "Create New Group",
                                            style: GoogleFonts.workSans(
                                              // ignore: prefer_const_constructors
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: .2),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                child: Text("You are in groups"),
              );
            }
          } else {
            throw Error;
          }
        },
      ),
    );
  }
}
