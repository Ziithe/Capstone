import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/home.dart';
import 'package:mgulu_savings/constants/utils.dart';

import '../Welcome/welcome.dart';
import '../constants/constants.dart';
import '../constants/size.dart';

class emailVerification extends StatefulWidget {
  final String? uid;
  const emailVerification({Key? key, this.uid}) : super(key: key);

  @override
  State<emailVerification> createState() => _emailVerificationState();
}

class _emailVerificationState extends State<emailVerification> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    // call after email verification!
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
          body: SafeArea(
              child: SizedBox(
          child: Column(children: [
            SizedBox(height: screenHeight(context) * 0.1),
            SvgPicture.asset(
              "assets/Images/Process.svg",
              height: screenHeight(context) * 0.45,
            ),
            SizedBox(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Text(
                    "Please Verify your email!",
                    style: GoogleFonts.workSans(
                      // ignore: prefer_const_constructors
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 12, right: 12, bottom: 16),
                    child: Text(
                      "We sent a code to your email address",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        // ignore: prefer_const_constructors
                        textStyle: TextStyle(
                            color: textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            letterSpacing: .2),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * 0.03),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth(context) * 0.8,
                          screenHeight(context) * 0.06),
                      primary: primaryColor,
                    ),
                    icon: Icon(Icons.email, size: 20),
                    label: Text(
                      'Resend Email',
                      style: GoogleFonts.workSans(
                        // ignore: prefer_const_constructors
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .2),
                      ),
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.workSans(
                        // ignore: prefer_const_constructors
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .2),
                      ),
                    ),
                    onPressed: () =>
                        FirebaseAuth.instance.signOut().then((res) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                          (Route<dynamic> route) => false);
                    }),
                  ),
                ],
              ),
            ),
          ]),
        )));
}
