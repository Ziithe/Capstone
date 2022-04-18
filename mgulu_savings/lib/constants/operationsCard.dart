import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/constants/size.dart';

class operationsCard extends StatelessWidget {
  final String iconPath;
  final String titleText;
  final String subTitle;

  const operationsCard(
      {required this.iconPath,
      required this.titleText,
      required this.subTitle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, blurRadius: 20, spreadRadius: 2)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: screenHeight(context) * 0.04,
                    child: Image.asset(iconPath),
                  ),
                  SizedBox(
                    width: screenWidth(context) * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleText,
                        style:
                            GoogleFonts.workSans(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.005,
                      ),
                      Text(subTitle,
                          style: GoogleFonts.workSans(
                              fontSize: 11, color: textColor))
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: primaryColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}
