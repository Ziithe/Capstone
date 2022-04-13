import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Welcome/welcome.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/constants/size.dart';

class Profile extends StatelessWidget {
  final String? uid;
  const Profile({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

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
                height: screenHeight(context) * 0.08,
              ),
              CircleAvatar(
                radius: screenHeight(context) * 0.06,
                backgroundColor: primaryColor,
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser!.uid)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final str = '${data['fullname']}';
                      return Text(
                        str.split(" ").map((l) => l[0]).take(2).join(),
                        style: GoogleFonts.workSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight(context) * 0.04),
                      );
                    } else {
                      throw Error;
                    }
                  },
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.04,
              ),
              ListTile(
                leading: Icon(Icons.person, color: primaryColor),
                title: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser.uid)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Text(
                        '${data['fullname']}',
                        style: GoogleFonts.workSans(),
                      );
                    } else {
                      throw Error;
                    }
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.email, color: primaryColor),
                title: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser.uid)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Text(
                        '${data['email']}',
                        style: GoogleFonts.workSans(),
                      );
                    } else {
                      throw Error;
                    }
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.fingerprint_rounded, color: primaryColor),
                title: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser.uid)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Text(
                        '${data['passid']}',
                        style: GoogleFonts.workSans(),
                      );
                    } else {
                      throw Error;
                    }
                  },
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.07,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: primaryColor,
                ),
                title: const Text(
                  "Sign out",
                ),
                onTap: () {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((res) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                        (Route<dynamic> route) => false);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
