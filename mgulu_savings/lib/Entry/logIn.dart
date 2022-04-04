import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgulu_savings/Screens/home.dart';

import '../constants.dart';
import '../main.dart';
import '../size.dart';
import '../utils.dart';

class LogInScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LogInScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool _hiddenPass = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

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
                        child: Column(children: [
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
                          "Welcome Back",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight(context) * 0.03),
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email Address",
                                  style: const TextStyle(
                                      fontSize: 18,
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
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight(context) * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: const TextStyle(
                                      fontSize: 18,
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
                                      child:
                                          const Icon(Icons.visibility_outlined),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
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
                                          "Log In",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            loginToFirebase();
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
                                    text: 'No account?  ',
                                    children: [
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = widget.onClickedSignUp,
                                          text: 'Register Here',
                                          style: GoogleFonts.workSans(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      )
                    ]))))));
  }

  void _passwordVisible() {
    setState(() {
      _hiddenPass = !_hiddenPass;
    });
  }

  void loginToFirebase() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
}
