import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/createGroup.dart';
import 'package:mgulu_savings/Screens/Pages/joinGroup.dart';
import 'package:mgulu_savings/Screens/RotationalGroup/rotGroupInfo.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/SLGroupInfor.dart';

import '../../constants/constants.dart';
import '../../constants/size.dart';
import '../../management/groupClass.dart';

class GroupPage extends StatefulWidget {
  final String? uid;
  const GroupPage({Key? key, this.uid}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  var currentUser = FirebaseAuth.instance.currentUser;
  groupsCard(groupsClass attribute) {
    return InkWell(
      onTap: () {
        if (attribute.groupType == 'Savings and Loan Group') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SLGroupInfo(
                        groupName: attribute.groupName,
                        groupType: attribute.groupType,
                        groupGoal: attribute.groupGoal,
                        groupLimit: attribute.groupLimit,
                        frequency: attribute.frequency,
                        startOn: attribute.startDate,
                        endOn: attribute.endDate,
                        members: attribute.members.length,
                        groupId: attribute.groupId,
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => rotGroupInfo(
                        groupName: attribute.groupName,
                        groupType: attribute.groupType,
                        groupGoal: attribute.groupGoal,
                        groupLimit: attribute.groupLimit,
                        frequency: attribute.frequency,
                        startOn: attribute.startDate,
                        endOn: attribute.endDate,
                        members: attribute.members.length,
                        groupId: attribute.groupId,
                      )));
        }
      },
      child: Container(
          padding: EdgeInsets.all(16.0),
          height: screenHeight(context) * 0.2,
          width: screenWidth(context) * 0.8,
          decoration: BoxDecoration(
            color: primaryLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text(
                                  attribute.groupName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                attribute.groupType,
                                style: TextStyle(
                                    color: textSecondary, fontSize: 13),
                              ),
                            ],
                          ),
                          SizedBox(width: screenWidth(context) * 0.25),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Members",
                                style: TextStyle(
                                    color: textSecondary, fontSize: 11),
                              ),
                              Text((attribute.members.length).toString() +
                                  '/' +
                                  attribute.groupLimit),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            attribute.groupGoal,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(attribute.groupId),
                          IconButton(
                              onPressed: () async {
                                await FlutterClipboard.copy(attribute.groupId)
                                    .then(
                                        (value) => print("Group Code Copied"));
                              },
                              icon: Icon(Icons.copy_rounded))
                        ],
                      ),
                    ])
              ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myGroups = FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.uid)
            .collection("myGroups")
            .get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: screenHeight(context) * 0.03,
                );
              },
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<dynamic, dynamic> groupMap =
                    snapshot.data!.docs[index].data();

                groupsClass attribute = groupsClass(
                  groupMap['groupId'],
                  groupMap['groupName'],
                  groupMap['admin'],
                  groupMap['limit'],
                  groupMap['groupType'],
                  groupMap['goal'],
                  groupMap['frequency'],
                  groupMap['startOn'],
                  groupMap['endOn'],
                  groupMap['members'],
                );
                return groupsCard(attribute);
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error");
          }
          throw Error();
        });

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser!.uid)
              .collection("myGroups")
              .doc()
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Oops, something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.none) {
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        joinGroup()));
                                          },
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
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                floatingActionButton: SpeedDial(
                  spaceBetweenChildren: 12,
                  spacing: 12,
                  backgroundColor: primaryColor,
                  activeBackgroundColor: secondaryColor,
                  animatedIcon: AnimatedIcons.menu_close,
                  children: [
                    SpeedDialChild(
                        child: Icon(
                          Icons.person_add_rounded,
                          color: primaryColor,
                        ),
                        label: 'Join New Group',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => joinGroup()));
                        }),
                    SpeedDialChild(
                        child: Icon(
                          Icons.create_new_folder_rounded,
                          color: primaryColor,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => createGroup()));
                        },
                        label: 'Create New Group')
                  ],
                ),
                body: SafeArea(
                    child: SizedBox(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: screenHeight(context) * 0.01,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text("Your Groups",
                                  style: GoogleFonts.workSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(
                            height: screenHeight(context) * 0.03,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text("Tap on Card to View Group Details",
                                  style: GoogleFonts.workSans(
                                    color: textColor,
                                  ))),
                          SizedBox(
                            height: screenHeight(context) * 0.03,
                          ),
                          Container(
                            child: myGroups,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              );
            } else {
              throw Error;
            }
          }),
    );
  }
}
