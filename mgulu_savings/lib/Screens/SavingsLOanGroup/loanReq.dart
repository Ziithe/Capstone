import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/home.dart';
import 'package:mgulu_savings/constants/size.dart';

import '../../constants/constants.dart';

class requestLoan extends StatefulWidget {
  final String? uid;
  final String? groupName;
  final String? groupId;

  const requestLoan({
    Key? key,
    this.uid,
    this.groupName,
    this.groupId,
  }) : super(key: key);

  @override
  State<requestLoan> createState() => _requestLoanState();
}

class _requestLoanState extends State<requestLoan> {
  final _formKey = GlobalKey<FormState>();
  final senderController = TextEditingController();
  final receiverController = TextEditingController();
  final amountController = TextEditingController();
  final endDateController = TextEditingController();

  bool isLoading = false;

  var currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final String? groupId = this.widget.groupId;

    final FullName = FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            '${data['fullname']}',
            style: GoogleFonts.workSans(fontSize: 13, color: textSecondary),
          );
        } else {
          throw Error;
        }
      },
    );

    final email = FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            '${data['email'].toString()}',
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
        iconTheme: IconThemeData(color: primaryColor),
        title: Text('Request Loan',
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
                    "Your Full Name",
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
                  child: FullName,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(height: screenHeight(context) * 0.03),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Your Email",
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
                  child: email,
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
                            "Amount",
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
                            inputFormatters: [
                              CurrencyTextInputFormatter(
                                name: 'MWK ',
                              )
                            ],
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (String? stringValue) {
                              if (stringValue != null && stringValue.isEmpty) {
                                return "Goal cannot be empty";
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
                            "Repay On",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, color: textColor),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0)),
                          DateTimePicker(
                            type: DateTimePickerType.date,
                            dateMask: "d MMMM, yyyy",
                            controller: endDateController,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050),
                            validator: (String? stringValue) {
                              if (stringValue != null && stringValue.isEmpty) {
                                return "Please enter end date";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                          )
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
                                    "Send Request",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      requestLoan(groupId.toString(), user.uid);
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
                                    Navigator.pop(context);
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

  void requestLoan(String groupId, String uid) async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();

    DocumentSnapshot groupData = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();

    try {
      //Add to users group collection
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("myGroups")
          .doc(groupId)
          .collection('myLoans')
          .add({
        'amount': amountController.text,
        'loanDueDate': endDateController.text,
        'status': 'Pending Approval',
        'requestDate': Timestamp.now()
      });

      //Add to group collection
      await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("loanRequests")
          .add({
        'amount': amountController.text,
        'loanDueDate': endDateController.text,
        'requestDate': Timestamp.now(),
        'requestFrom': userData.get('fullname'),
        'requestId': userData.get('passid'),
        'requestEmail': userData.get('email'),
        'status': 'Pending Approval'
      });

      //Add to users activity collection
      await _firestore.collection("users").doc(uid).collection("Activity").add({
        'amount': amountController.text,
        'comment': 'Success',
        'details': 'Loan Request to ' + groupData.get('groupName'),
        'date': Timestamp.now(),
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AlertDialog(
                    title: Text(
                      "Loan Request Success!",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w700, color: successColor),
                    ),
                    content: Text(
                      "Await Approval from your group",
                      style:
                          GoogleFonts.workSans(color: textColor, fontSize: 13),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        uid: uid,
                                      ))),
                          child: Text(
                            "Return to Home",
                            style: GoogleFonts.workSans(),
                          ))
                    ],
                  )));
    } catch (e) {
      throw Error();
    }
  }
}
