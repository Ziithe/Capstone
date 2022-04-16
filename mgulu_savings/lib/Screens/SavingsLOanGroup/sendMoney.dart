import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/constants/size.dart';

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

  bool isLoading = false;

  var currentUser = FirebaseAuth.instance.currentUser;

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
        iconTheme: IconThemeData(color: primaryColor),
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sender",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, color: textColor),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0)),
                          TextFormField(
                            controller: senderController,
                            obscureText: false,
                            cursorColor: textColor,
                            textInputAction: TextInputAction.next,
                            validator: (String? stringValue) {
                              if (stringValue != null && stringValue.isEmpty) {
                                return "This is a required field, please enter sender info here";
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
                      SizedBox(
                        height: screenHeight(context) * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sender Email",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, color: textColor),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0)),
                          TextFormField(
                            controller: senderController,
                            obscureText: false,
                            cursorColor: textColor,
                            textInputAction: TextInputAction.next,
                            validator: (String? stringValue) {
                              if (stringValue != null && stringValue.isEmpty) {
                                return "This is a required field, please enter sender info here";
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
                      SizedBox(
                        height: screenHeight(context) * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Receiver",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, color: textColor),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0)),
                          TextFormField(
                            controller: senderController,
                            obscureText: false,
                            cursorColor: textColor,
                            textInputAction: TextInputAction.next,
                            validator: (String? stringValue) {
                              if (stringValue != null && stringValue.isEmpty) {
                                return "This is a required field, please enter sender info here";
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
                                name: 'MWK',
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
}
