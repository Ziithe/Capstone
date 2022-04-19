import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/loanData.dart';
import 'package:mgulu_savings/Screens/SavingsLoanGroup/myLoanCard.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/constants/size.dart';

class myLoans extends StatefulWidget {
  final groupId;

  const myLoans({Key? key, this.groupId}) : super(key: key);

  @override
  State<myLoans> createState() => _myLoansState();
}

class _myLoansState extends State<myLoans> {
  List<Object> _loanList = [];

  @override
  void didChangeDependencies() {
    final String groupId = this.widget.groupId;
    super.didChangeDependencies();
    getmyLoans(groupId);
  }

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
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: screenHeight(context) * 0.01,
                        );
                      },
                      itemCount: _loanList.length,
                      itemBuilder: (context, index) {
                        return myLoanCard(
                            loan: _loanList[index] as loanRequests);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getmyLoans(String groupId) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    var data = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('myGroups')
        .doc(groupId)
        .collection('myLoans')
        .orderBy('requestDate', descending: true)
        .get();

    setState(() {
      _loanList =
          List.from(data.docs.map((doc) => loanRequests.fromSnapshot(doc)));
    });
  }
}
