import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/Pages/groups.dart';
import 'package:mgulu_savings/constants/size.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

import '../../constants/constants.dart';

class sendMoney extends StatefulWidget {
  final String? uid;
  final groupName;
  final groupId;

  const sendMoney({
    Key? key,
    this.uid,
    this.groupName,
    this.groupId,
  }) : super(key: key);

  @override
  State<sendMoney> createState() => _sendMoneyState();
}

class _sendMoneyState extends State<sendMoney> {
  final _formKey = GlobalKey<FormState>();
  final senderController = TextEditingController();
  final receiverController = TextEditingController();
  final amountController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;

  String? _ref;

  void setRef() {
    Random rand = Random();
    int number = rand.nextInt(2000);

    setState(() {
      _ref = "MguluRef12345$number";
    });
  }

  @override
  void initState() {
    setRef();
    super.initState();
  }

  var currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final String? groupId = this.widget.groupId;

    final groupName = FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection("groups").doc(groupId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            '${data['groupName'].toString()}',
            style: GoogleFonts.workSans(fontSize: 13, color: textSecondary),
          );
        } else {
          throw Error;
        }
      },
    );

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
        title: Text('Send Money',
            style: GoogleFonts.workSans(
                fontSize: 20, fontWeight: FontWeight.w700, color: textColor)),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight(context) * 0.03),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Sending To",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, color: textColor),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0)),
                Container(
                  height: screenHeight(context) * 0.055,
                  width: screenWidth(context),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: groupName,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(height: screenHeight(context) * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Confirm Full Name",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, color: textColor),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0)),
                          TextFormField(
                            controller: fullnameController,
                            obscureText: false,
                            cursorColor: textColor,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight(context) * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Confirm Email Address",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, color: textColor),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0)),
                          TextFormField(
                            controller: emailController,
                            obscureText: false,
                            cursorColor: textColor,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? stringValue) {
                              if (stringValue != null && stringValue.isEmpty) {
                                return "Your email address is a required field, please enter it here";
                              } else if (stringValue != null &&
                                  !stringValue.contains('@')) {
                                return "Please enter a valid email address with an @ symbol";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight(context) * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Confirm Phone Number",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, color: textColor),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0)),
                          TextFormField(
                            controller: phoneController,
                            obscureText: false,
                            cursorColor: textColor,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (intValue) {
                              if (intValue != null && intValue.isEmpty) {
                                return "Please Specify Amount to be sent";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                          ),
                          SizedBox(height: screenHeight(context) * 0.03),
                          Text(
                            "Amount in RWF",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, color: textColor),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0)),
                          TextFormField(
                            controller: amountController,
                            obscureText: false,
                            cursorColor: textColor,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (intValue) {
                              if (intValue != null && intValue.isEmpty) {
                                return "Please Specify Amount to be sent";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight(context) * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 0,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                height: screenHeight(context) * 0.06,
                                child: MaterialButton(
                                  color: primaryColor,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 20.0),
                                  child: const Text(
                                    "Send Money",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      final email = emailController.text.trim();
                                      final name =
                                          fullnameController.text.trim();
                                      _makePayment(context, email, name,
                                          groupId.toString());
                                    }
                                  },
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 0,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                height: screenHeight(context) * 0.06,
                                child: MaterialButton(
                                  color: Colors.white,
                                  textColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 20.0),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                    }
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _makePayment(
      BuildContext context, String email, String name, String groupId) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: this.context,
        encryptionKey: "FLWSECK_TESTb3df1a2e71d6",
        publicKey: "FLWPUBK_TEST-bcec4664f929fcb7665865ef202ed754-X",
        currency: "RWF",
        amount: amountController.text,
        email: email,
        fullName: name,
        txRef: _ref!,
        isDebugMode: true,
        phoneNumber: phoneController.text,
        acceptCardPayment: false,
        acceptUSSDPayment: false,
        acceptAccountPayment: false,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: true,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false,
      );

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();

      // ignore: unnecessary_null_comparison
      if (response == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AlertDialog(
                      title: Text(
                        "Transaction Failed",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w700, color: failColor),
                      ),
                      content: Text(
                        "Please try again later",
                        style: GoogleFonts.workSans(
                            color: textColor, fontSize: 13),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GroupPage())),
                            child: Text(
                              "Return to My Groups",
                              style: GoogleFonts.workSans(),
                            ))
                      ],
                    )));
      } else {
        if (response.status == "success") {
          sendMoney(user.uid, groupId);
        } else {
          print(response.message);
          print(response.data?.processorResponse);
        }
      }
    } catch (error) {
      throw Error();
    }
  }

  void sendMoney(String uid, String groupId) async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();

    DocumentSnapshot groupData = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();

    try {
      //Add infor to Group Collection
      await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("groupTransactions")
          .add({
        'amount': amountController.text,
        'sendDate': Timestamp.now(),
        'senderName': userData.get('fullname'),
        'senderEmail': userData.get('email'),
        'uid': uid,
        'details': "RWF " +
            amountController.text +
            " received from " +
            userData.get("fullname"),
        'comment': "Success"
      });
      final double amount = double.parse(amountController.text);

      //Add infor to users collection
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("myGroups")
          .doc(groupId)
          .collection('myTransactions')
          .add({
        'amount': amountController.text,
        'sendDate': Timestamp.now(),
        'details': "RWF " +
            amountController.text +
            " sent to " +
            groupData.get("groupName"),
        'comment': "Success"
      });

      //Add infor to Activities collection
      await _firestore.collection("users").doc(uid).collection("Activity").add({
        'amount': amountController.text,
        'comment': 'Success',
        'details': "RWF " +
            amountController.text +
            " sent to " +
            groupData.get("groupName"),
        'date': Timestamp.now(),
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GroupPage()));
    } catch (e) {
      throw Error();
    }
  }
}
