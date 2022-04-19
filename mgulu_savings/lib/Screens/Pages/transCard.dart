import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/transactions.dart';
import 'package:mgulu_savings/constants/constants.dart';

class transCard extends StatelessWidget {
  final groupTransaction transaction;
  const transCard({Key? key, required this.transaction}) : super(key: key);

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
            children: [
              Text(
                "Sender: ",
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600, color: textColor),
              ),
              Text(transaction.senderName.toString())
            ],
          ),
          Row(
            children: [
              Text(
                "Amount: ",
                style: GoogleFonts.workSans(fontWeight: FontWeight.w600),
              ),
              Text("RWF " + transaction.amount.toString())
            ],
          ),
          Row(
            children: [
              Text(
                "Date: ",
                style: GoogleFonts.workSans(fontWeight: FontWeight.w600),
              ),
              Text(transaction.sendDate!.toDate().toString())
            ],
          ),
        ],
      ),
    );
  }
}
