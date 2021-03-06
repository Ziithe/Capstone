import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/transCard.dart';
import 'package:mgulu_savings/Screens/Pages/transactions.dart';

import '../../constants/constants.dart';
import '../../constants/size.dart';

class groupTransactions extends StatefulWidget {
  final groupId;
  const groupTransactions({Key? key, required this.groupId}) : super(key: key);

  @override
  State<groupTransactions> createState() => _groupTransactionsState();
}

class _groupTransactionsState extends State<groupTransactions> {
  List<Object> _transactionList = [];

  @override
  void didChangeDependencies() {
    final String groupId = this.widget.groupId;
    super.didChangeDependencies();
    getgroupTransactions(groupId);
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
        title: Text("Group Transactions",
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
                        return transCard(
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

  Future getgroupTransactions(String groupId) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // final user = FirebaseAuth.instance.currentUser!;

    var data = await _firestore
        .collection('groups')
        .doc(groupId)
        .collection('groupTransactions')
        .orderBy('sendDate', descending: true)
        .get();

    setState(() {
      _transactionList =
          List.from(data.docs.map((doc) => groupTransaction.fromSnapshot(doc)));
    });
  }
}
