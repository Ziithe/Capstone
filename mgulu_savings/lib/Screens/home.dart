import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:mgulu_savings/Entry/logIn.dart';
import 'package:mgulu_savings/Screens/Pages/body.dart';
import 'package:mgulu_savings/Screens/Pages/groups.dart';
import 'package:mgulu_savings/Screens/Pages/notifications.dart';
import 'package:mgulu_savings/Screens/Pages/profile.dart';
import 'package:mgulu_savings/Welcome/welcome.dart';
import 'package:mgulu_savings/constants/constants.dart';
import 'package:mgulu_savings/constants/size.dart';

class HomePage extends StatefulWidget {
  final String? uid;
  const HomePage({Key? key, this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentUser = FirebaseAuth.instance.currentUser;
  Future getUser() async {}

  int index = 0;
  final screens = [Body(), GroupPage(), Notifications(), Profile()];

  FirebaseAuth authUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: textColor),
          title: Image.asset("assets/Images/WBG_Icon.png",
              fit: BoxFit.contain, height: 26.0, width: 26.0),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Open Settings',
                onPressed: () {}),
          ]),
      drawer: buildDrawer(),
      body: screens[index],
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  Widget buildDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              accountName: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUser!.uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("sth went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Text(
                      '${data['fullname']}',
                      style: GoogleFonts.workSans(),
                    );
                  } else {
                    throw Error;
                  }
                },
              ),
              accountEmail: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUser!.uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Oops, something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Row(
                      children: [
                        Text("ID Number: ",
                            style: GoogleFonts.workSans(
                                fontWeight: FontWeight.bold)),
                        Text('${data['passid']}', style: GoogleFonts.workSans())
                      ],
                    );
                  } else {
                    throw Error;
                  }
                },
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser!.uid)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final str = '${data['fullname']}';
                      return Text(
                        str.split(" ").map((l) => l[0]).take(2).join(),
                        style: GoogleFonts.workSans(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      );
                    } else {
                      throw Error;
                    }
                  },
                ),
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: const Icon(
                  Icons.person_outline_rounded,
                  color: primaryColor,
                ),
                onPressed: () {},
              ),
              title: const Text(
                "My Profile",
              ),
              onTap: () {},
            ),
            ListTile(
              leading: IconButton(
                  icon: const Icon(
                    Icons.people_outline_rounded,
                    color: primaryColor,
                  ),
                  onPressed: () {}),
              title: const Text(
                "My Groups",
              ),
              onTap: () {},
            ),
            ListTile(
              leading: IconButton(
                  icon: const Icon(
                    Icons.chat_bubble_rounded,
                    color: primaryColor,
                  ),
                  onPressed: () {}),
              title: const Text(
                "My Activities",
              ),
              onTap: () {},
            ),
            SizedBox(
              height: screenHeight(context) * 0.3,
            ),
            Divider(
              color: Colors.grey,
              height: 10,
              thickness: 1,
            ),
            ListTile(
              leading: IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: primaryColor,
                ),
                onPressed: () => authUser.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false);
                }),
              ),
              title: const Text(
                "Sign out",
              ),
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false);
                });
              },
            ),
          ],
        ),
      );

  Widget buildNavigationBar() => NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
              GoogleFonts.workSans(fontSize: 14, fontWeight: FontWeight.w500)),
          indicatorColor: Colors.blue.shade100,
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: screenHeight(context) * 0.08,
          backgroundColor: Colors.white,

          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          // animationDuration: Duration(seconds: 3),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.group_outlined),
              selectedIcon: Icon(Icons.group),
              label: 'Groups',
            ),
            NavigationDestination(
              icon: Icon(Icons.mail_outline_rounded),
              selectedIcon: Icon(Icons.mail_rounded),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      );
}
