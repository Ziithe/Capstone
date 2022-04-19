import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/groupLoans.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/groupTransactions.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/yourLoans.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/yourTransactions.dart';
import 'package:mgulu_savings/constants/operationsCard.dart';
import 'package:mgulu_savings/constants/servicesButton.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/loanReq.dart';
import 'package:mgulu_savings/Screens/SavingsLOanGroup/sendMoney.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/constants/size.dart';
import 'package:share_plus/share_plus.dart';

class SLGroupInfo extends StatefulWidget {
  final groupName;
  final groupType;
  final groupGoal;
  final groupLimit;
  final frequency;
  final startOn;
  final endOn;
  final members;
  final groupId;

  const SLGroupInfo(
      {Key? key,
      this.groupName,
      this.groupType,
      this.groupGoal,
      this.groupLimit,
      this.frequency,
      this.startOn,
      this.endOn,
      this.members,
      this.groupId})
      : super(key: key);

  @override
  State<SLGroupInfo> createState() => _SLGroupInfoState();
}

class _SLGroupInfoState extends State<SLGroupInfo> {
  @override
  Widget build(BuildContext context) {
    String groupName = this.widget.groupName;
    String groupId = this.widget.groupId;

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
        title: Text(groupName,
            style: GoogleFonts.workSans(
                fontSize: 20, fontWeight: FontWeight.w700, color: textColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(16.0),
                    height: screenHeight(context) * 0.2,
                    decoration: BoxDecoration(
                      color: primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 6.0),
                                          child: Text(
                                            this.widget.groupName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          this.widget.groupType,
                                          style: TextStyle(
                                              color: textSecondary,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        width: screenWidth(context) * 0.25),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Members",
                                          style: TextStyle(
                                              color: textSecondary,
                                              fontSize: 11),
                                        ),
                                        Text((this.widget.members.toString()) +
                                            '/' +
                                            this.widget.groupLimit),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          this.widget.groupGoal,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          " / " + this.widget.frequency,
                                          style: TextStyle(
                                              color: textSecondary,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(this.widget.startOn +
                                        ' - ' +
                                        this.widget.endOn),
                                  ],
                                ),
                              ])
                        ])),
                SizedBox(
                  height: screenHeight(context) * 0.04,
                ),
                Row(
                  children: [
                    Text(
                      "Services",
                      style: GoogleFonts.workSans(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sendMoney(
                                      groupName: groupName,
                                      groupId: groupId,
                                    )));
                      },
                      child: serviceButton(
                          imagePath: 'assets/Images/sendMoney.png',
                          buttonText: "Send Money"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => requestLoan(
                                      groupName: groupName,
                                      groupId: groupId,
                                    )));
                      },
                      child: serviceButton(
                          imagePath: 'assets/Images/requestLoan.png',
                          buttonText: "Request Loan"),
                    ),
                    InkWell(
                      onTap: () async {
                        if (groupId.isNotEmpty) {
                          await Share.share(
                              "Hey there! I created a Savings Group on the m'Gulu Savings App. Join me in saving by using this Group Code: \n \n" +
                                  groupId);
                        } else {
                          throw Error();
                        }
                      },
                      child: serviceButton(
                          imagePath: 'assets/Images/Invite.png',
                          buttonText: "Invite Friends"),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.04,
                ),
                Row(
                  children: [
                    Text(
                      "Group Operations",
                      style: GoogleFonts.workSans(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    groupTransactions(groupId: groupId)));
                      },
                      child: operationsCard(
                          iconPath: "assets/Images/transaction.png",
                          titleText: "Group Transactions",
                          subTitle: "View all Group Transactions"),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    groupLoans(groupId: groupId)));
                      },
                      child: operationsCard(
                          iconPath: "assets/Images/loan.png",
                          titleText: "Group Loans",
                          subTitle: "View all Group Loans"),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Row(
                  children: [
                    Text(
                      "Your Operations",
                      style: GoogleFonts.workSans(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    yourTransactions(groupId: groupId)));
                      },
                      child: operationsCard(
                          iconPath: "assets/Images/credit-card.png",
                          titleText: "Your Transactions",
                          subTitle: "View all your Transactions in this Group"),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => myLoans(
                                      groupId: groupId,
                                    )));
                      },
                      child: operationsCard(
                          iconPath: "assets/Images/myloan.png",
                          titleText: "Your Loans",
                          subTitle: "View all your loans in this Group"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
