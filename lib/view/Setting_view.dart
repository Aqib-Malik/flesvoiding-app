import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flesvoieding/view/Bottom_Nav_Bar.dart';
import 'package:flesvoieding/view/Faq_view.dart';
import 'package:flesvoieding/view/Login_view.dart';
import 'package:flesvoieding/view/Profile_view.dart';
import 'package:flesvoieding/view/Terms&Conditions.dart';
import 'package:flesvoieding/view/history.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../commonWidgetss/CommonWidgets.dart';

class Settings_view extends StatefulWidget {
  const Settings_view({Key, key}) : super(key: key);

  @override
  _Settings_viewState createState() => _Settings_viewState();
}

class _Settings_viewState extends State<Settings_view> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  var status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Instellingen',
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         Icon(
              //           FontAwesomeIcons.bell,
              //           color: Colors.black,
              //         ),
              //         Text(
              //           '     Notificaties aan/uit',
              //           style: GoogleFonts.inter(
              //               fontSize: 16,
              //               fontWeight: FontWeight.w400,
              //               color: Colors.black),
              //         )
              //       ],
              //     ),
              //     FlutterSwitch(
              //       width: 50.0,
              //       height: 25.0,
              //       toggleSize: 25.0,
              //       value: status,
              //       borderRadius: 30.0,
              //       padding: 2.0,
              //       toggleColor: Colors.yellow.shade700,
              //       activeColor: Colors.grey.shade300,
              //       inactiveColor: Colors.grey.shade300,
              //       onToggle: (val) {
              //         setState(() {
              //           status = val;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Divider(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Profile_view()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text(
                      '    Bekijk profiel',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: eraseData,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/images/eraser.png'),
                    ),
                    Text(
                      '   Wis mijn persoonlijke data',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  CommonWidgets.confirmBox("verwijderen",
                      "weet je zeker dat je je account wilt verwijderen?", () {
                    deactivateAccount();
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.highlight_remove,
                      color: Colors.red,
                      size: 30,
                    ),
                    Text(
                      '   Deactiveer mijn account',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Faq_view()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: Colors.red,
                      size: 30,
                    ),
                    Text(
                      '   Neem contact met ons op',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Terms()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text(
                      '   Algemene voorwaarden',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => History()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text(
                      '   Geschiedenis',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  CommonWidgets.confirmBox(
                    "uitloggen",
                    "Weet u zeker dat u wilt uitloggen?",
                    () async {
                      FirebaseAuth.instance.signOut();
                      await GoogleSignIn().signOut();
                      Get.offAll(Login_view());
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text(
                      '   Uitloggen',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deactivateAccount() async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('users').doc(currentUser);

      await docUser.delete();

      FirebaseAuth.instance.currentUser!.delete();
      Get.offAll(Login_view());
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  eraseData() async {
    CommonWidgets.confirmBox(
        "verwijderen", "weet je zeker dat je alle gegevens wilt wissen?",
        () async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .update(
        {
          "name": "",
          "imageUrl": "",
          "birthDate": DateTime.now(),
          "today_milk": []
        },
      ).whenComplete(() => Get.offAll(Bottom_Nav_Bar(currentIndex: 0)));
    });

    // docUser.docs.forEach((element) {
    //   FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(currentUser).collection('milk').doc(element.id).delete();
    // });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(
        "Personal Data Erased Successfully",
        style: TextStyle(color: Colors.black),
      ),
    ));
  }
}
