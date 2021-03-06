import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/loanData.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/constants/size.dart';

class loanCard extends StatelessWidget {
  final loanRequests loan;
  const loanCard({Key? key, required this.loan}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Request From: ",
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600, color: textColor),
              ),
              Text(loan.requestFrom.toString())
            ],
          ),
          SizedBox(
            height: screenHeight(context) * 0.005,
          ),
          Row(
            children: [
              Text(
                "Amount: ",
                style: GoogleFonts.workSans(fontWeight: FontWeight.w600),
              ),
              Text(loan.amount.toString())
            ],
          ),
          SizedBox(
            height: screenHeight(context) * 0.005,
          ),
          Row(
            children: [
              Text(
                "Due Date: ",
                style: GoogleFonts.workSans(fontWeight: FontWeight.w600),
              ),
              Text(loan.loanDueDate!.toString())
            ],
          ),
          SizedBox(
            height: screenHeight(context) * 0.005,
          ),
          Row(
            children: [
              Text(
                "Status: ",
                style: GoogleFonts.workSans(fontWeight: FontWeight.w600),
              ),
              Text(
                loan.status.toString(),
                style: GoogleFonts.workSans(color: warningColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
