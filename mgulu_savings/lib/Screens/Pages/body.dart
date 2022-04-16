import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/activityCard.dart';
import 'package:mgulu_savings/Screens/Pages/recentActivity.dart';
import 'package:mgulu_savings/constants/size.dart';
import 'package:mgulu_savings/management/groupClass.dart';

import '../../constants/constants.dart';

class Body extends StatefulWidget {
  final String? uid;
  const Body({Key? key, this.uid}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var currentUser = FirebaseAuth.instance.currentUser;
  List<Object> _activityList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUsersActivity();
  }

  groupsCard(groupsClass attribute) {
    return Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(right: 10),
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
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              attribute.groupType,
                              style:
                                  TextStyle(color: textSecondary, fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth(context) * 0.2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Members",
                              style:
                                  TextStyle(color: textSecondary, fontSize: 11),
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
                              await FlutterClipboard.copy(attribute.groupId);
                            },
                            icon: Icon(Icons.copy_rounded))
                      ],
                    ),
                  ])
            ]));
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
          if (snapshot.connectionState == ConnectionState.none) {
            return Container(
                child: Column(
              children: [
                Image.asset(
                  "assets/Images/noData.gif",
                  height: screenHeight(context) * 0.25,
                  width: screenWidth(context) * 0.7,
                ),
                Center(
                  child: Text(
                    "Hmm.. Seems you’re not in any groups yet :(",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .2),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.01,
                ),
                Center(
                  child: Text(
                    "Navigate to the Groups Tab to Start Saving Now!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                        color: textColor, fontSize: 13, letterSpacing: .2),
                  ),
                ),
              ],
            ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
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

    final UserName = FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            '${data['fullname']}',
            style:
                GoogleFonts.workSans(fontSize: 20, fontWeight: FontWeight.w700),
          );
        } else {
          throw Error;
        }
      },
    );

    return SafeArea(
        child: SizedBox(
      height: screenHeight(context),
      width: screenWidth(context),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenHeight(context) * 0.01,
              ),
              Align(alignment: Alignment.topLeft, child: Text("Hello,")),
              SizedBox(
                height: screenHeight(context) * 0.01,
              ),
              Row(
                children: [UserName],
              ),
              SizedBox(
                height: screenHeight(context) * 0.03,
              ),
              Row(
                children: [
                  Text(
                    "Your Groups",
                    style: GoogleFonts.workSans(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context) * 0.03,
              ),
              Container(
                height: screenHeight(context) * 0.2,
                child: myGroups,
              ),
              SizedBox(
                height: screenHeight(context) * 0.03,
              ),
              Row(
                children: [
                  Text(
                    "Recent Activity",
                    style: GoogleFonts.workSans(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context) * 0.03,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: screenHeight(context) * 0.01,
                    );
                  },
                  itemCount: _activityList.length ~/ 2,
                  itemBuilder: (context, index) {
                    return activityCard(
                        activity: _activityList[index] as Activity);
                  })
            ],
          ),
        ),
      ),
    ));
  }

  Future getUsersActivity() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    var data = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('Activity')
        .orderBy('date', descending: true)
        .get();

    setState(() {
      _activityList =
          List.from(data.docs.map((doc) => Activity.fromSnapshot(doc)));
    });
  }
}
