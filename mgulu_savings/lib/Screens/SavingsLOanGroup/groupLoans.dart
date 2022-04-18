import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/constants/constants.dart';

class groupLoans extends StatefulWidget {
  final groupId;
  final uid;

  const groupLoans({Key? key, this.groupId, this.uid}) : super(key: key);

  @override
  State<groupLoans> createState() => _groupLoansState();
}

class _groupLoansState extends State<groupLoans> {
  List<Object> loanList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: textColor),
        title: Text('Group Loans',
            style: GoogleFonts.workSans(
                fontSize: 20, fontWeight: FontWeight.w700, color: textColor)),
        centerTitle: true,
      ),
    );
  }
}
