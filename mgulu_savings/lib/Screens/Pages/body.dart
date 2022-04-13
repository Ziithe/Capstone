import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/activityCard.dart';
import 'package:mgulu_savings/Screens/Pages/card.dart';
import 'package:mgulu_savings/constants/size.dart';
import 'package:mgulu_savings/data/activity_data.dart';
import 'package:mgulu_savings/data/card_data.dart';

class Body extends StatefulWidget {
  final String? uid;
  const Body({Key? key, this.uid}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var currentUser = FirebaseAuth.instance.currentUser;

  // final groups = FirebaseFirestore.instance
  //     .collection("Users")
  //     .doc(currentUser!.uid)
  //     .get()
  //     .then((value) {
  //   myGroups = value.data()!['groupId'];
  //   print(myGroups);
  // });

  @override
  Widget build(BuildContext context) {
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

    // final groups = FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(currentUser!.uid)
    //     .get()
    //     .then((value) {
    //   myGroups = value.data()!['groupId'];
    //   print(myGroups);
    // });

    // late List<dynamic> myGroups;
    // final groups = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(currentUser!.uid)
    //     .get();

    final userGroups = FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          final str = '${data['groupId']}';
          return Text(str);
        } else {
          throw Error();
        }
      },
    );

    return SafeArea(
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
              Align(alignment: Alignment.topLeft, child: Text("Hello,")),
              SizedBox(
                height: screenHeight(context) * 0.01,
              ),
              Row(
                children: [UserName],
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              Container(
                height: screenHeight(context) * 0.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: myCards.length,
                    itemBuilder: (context, index) {
                      return MyCard(
                        card: myCards[index],
                      );
                    }),
              ),
              SizedBox(
                height: screenHeight(context) * 0.03,
              ),
              Text("Your Groups"),
              userGroups,

              // ListView.builder(
              //     itemCount: myGroups.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Text(myGroups[index]);
              //     }),
              Row(
                children: [
                  Text(
                    "Recent Activity",
                    style: GoogleFonts.workSans(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context) * 0.03,
              ),
              ListView.separated(
                  itemCount: myActivities.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: screenHeight(context) * 0.01,
                    );
                  },
                  itemBuilder: (context, index) {
                    return activityCard(activity: myActivities[index]);
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
