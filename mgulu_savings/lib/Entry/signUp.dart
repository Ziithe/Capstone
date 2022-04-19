import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Entry/verifyEmail.dart';
import 'package:mgulu_savings/constants/utils.dart';
import 'package:mgulu_savings/management/userclass.dart';
// ignore: unused_import
import 'package:mgulu_savings/Screens/home.dart';
import 'package:mgulu_savings/constants/constants.dart';

import '../constants/size.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final idController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;
  bool _hiddenPass = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    idController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/Images/blue_Logo.png",
                      height: screenHeight(context) * 0.07,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.03),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create an Account",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.03),
              Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: textColor),
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
                              "Email Address",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: textColor),
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
                                if (stringValue != null &&
                                    stringValue.isEmpty) {
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
                              "Passport/National ID Number",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: textColor),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 0)),
                            TextFormField(
                              controller: idController,
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
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "* We use this to verify user identity for security reasons",
                              style: GoogleFonts.workSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: failColor),
                            )
                          ],
                        ),
                        SizedBox(height: screenHeight(context) * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Set Password",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: textColor),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 0)),
                            TextFormField(
                              decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: _passwordVisible,
                                  child: const Icon(Icons.visibility_outlined),
                                ),
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              controller: passwordController,
                              cursorColor: textColor,
                              obscureText: _hiddenPass,
                              validator: (String? stringValue) {
                                if (stringValue != null &&
                                    stringValue.length < 8) {
                                  return "Please enter a password at least 8 character long password";
                                }
                                return null;
                              },
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20.0),
                                    child: const Text(
                                      "Register",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        createUserinFireStore(
                                            emailController.text,
                                            passwordController.text);
                                      }
                                    },
                                  ),
                                ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.workSans(
                                    color: textColor, fontSize: 13),
                                text: 'Already have an account?  ',
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = widget.onClickedSignIn,
                                      text: 'Log In Here',
                                      style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          )),
        ),
      )),
    );
  }

  void createUserinFireStore(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((res) => {
                  isLoading = false,
                  postUserDetailsToFirestore(),
                });
      } on Exception {
        Utils.showSnackBar("Email already registered");
      }
    }
  }

  postUserDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserClass userClass = UserClass();
    userClass.email = user!.email;
    userClass.uid = user.uid;
    userClass.fullname = fullnameController.text;
    userClass.passid = idController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userClass.toMap());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => emailVerification(
          uid: user.uid,
        ),
      ),
    );
  }

  void _passwordVisible() {
    setState(() {
      _hiddenPass = !_hiddenPass;
    });
  }
}
