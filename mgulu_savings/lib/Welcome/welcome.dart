import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Welcome/auth_page.dart';

import '../constants.dart';
import '../size.dart';

class WelcomeScreen extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight(context) * 0.09),
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/Images/blue_Logo.png",
                      height: screenHeight(context) * 0.07,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.03),
              SizedBox(
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/Images/welcome.svg",
                      height: screenHeight(context) * 0.45,
                    ),
                    SizedBox(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Text(
                            "Welcome to m'Gulu",
                            style: GoogleFonts.workSans(
                              // ignore: prefer_const_constructors
                              textStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 12, right: 12, bottom: 16),
                            child: Text(
                              "Save and grow your income with your community",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                // ignore: prefer_const_constructors
                                textStyle: TextStyle(
                                    color: textSecondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: .2),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight(context) * 0.08),
                    SizedBox(
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(screenWidth(context) * 0.8,
                                      screenHeight(context) * 0.06),
                                  primary: primaryColor,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AuthPage()));
                                // Navigator.pushNamed(
                                //     context, LogInScreen.routeName);
                              },
                              child: Text(
                                "Get Started",
                                style: GoogleFonts.workSans(
                                  // ignore: prefer_const_constructors
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
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
    );
  }
}
