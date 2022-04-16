import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/activityCard.dart';
import 'package:mgulu_savings/Screens/Pages/recentActivity.dart';
import 'package:mgulu_savings/constants/size.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Object> _activityList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUsersActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Notifications',
                      style: GoogleFonts.workSans(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context) * 0.02,
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
                      itemCount: _activityList.length,
                      itemBuilder: (context, index) {
                        return activityCard(
                            activity: _activityList[index] as Activity);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
