import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'size.dart';

class serviceButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;

  const serviceButton(
      {required this.imagePath, required this.buttonText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: screenHeight(context) * 0.1,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: primaryLight,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 20,
                    spreadRadius: 2)
              ]),
          child: Center(child: Image.asset(imagePath)),
        ),
        SizedBox(
          height: screenHeight(context) * 0.01,
        ),
        Text(
          buttonText,
          style: GoogleFonts.workSans(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
