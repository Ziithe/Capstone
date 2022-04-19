import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/transactions.dart';
import 'package:mgulu_savings/Screens/SavingsLoanGroup/yourTransCard.dart';

import '../../constants/constants.dart';
import '../../constants/size.dart';

class yourTransactions extends StatefulWidget {
  final groupId;
  const yourTransactions({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  State<yourTransactions> createState() => _yourTransactionsState();
}

class _yourTransactionsState extends State<yourTransactions> {
  List<Object> _transactionList = [];

  @override
  void didChangeDependencies() {
    final String groupId = this.widget.groupId;
    super.didChangeDependencies();
    getyourTransactions(groupId);
  }

  @override
  Widget build(BuildContext context) {
    // final String? groupId = this.widget.groupId;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text("Your Transactions",
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
                      itemCount: _transactionList.length,
                      itemBuilder: (context, index) {
                        return yourTransactionCard(
                            transaction:
                                _transactionList[index] as groupTransaction);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getyourTransactions(String groupId) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    var data = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('myGroups')
        .doc(groupId)
        .collection('myTransactions')
        .orderBy('sendDate', descending: true)
        .get();

    setState(() {
      _transactionList =
          List.from(data.docs.map((doc) => groupTransaction.fromSnapshot(doc)));
    });
  }
}
