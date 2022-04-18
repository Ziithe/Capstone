import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/groupLoans.dart';

class loanCard extends StatelessWidget {
  final groupLoans loans;

  const loanCard({Key? key, required this.loans}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Request From: ",
                  style: GoogleFonts.workSans(fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }
}
