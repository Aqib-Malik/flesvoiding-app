import 'package:flesvoieding/constant/Constants.dart';
import 'package:flesvoieding/model/googleSign.dart';
import 'package:flesvoieding/services/authservice.dart';
import 'package:flesvoieding/view/Bottom_Nav_Bar.dart';
import 'package:flesvoieding/view/Home_view.dart';
import 'package:flesvoieding/view/Signup_view.dart';
import 'package:flesvoieding/view/forgotPassword_view.dart';
import 'package:flesvoieding/widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login_view extends StatefulWidget {
  const Login_view({Key, key}) : super(key: key);

  @override
  _Login_viewState createState() => _Login_viewState();
}

class _Login_viewState extends State<Login_view> {
  var obscure = true;
  var check = true;

  bool loading = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Sign In',
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hi, welkom terug!  ',
                    style: GoogleFonts.inter(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    MdiIcons.handWave,
                    color: Colors.yellow.shade800,
                  )
                ],
              ),
              SizedBox(
                height: sh * 0.1,
              ),
              Text(
                'E-mailadres ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormFieldWithPrefix(
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                controller: _emailController,
                hintText: 'Vul je e-mailadres in',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Wachtwoord ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              CustomPasswordFormFieldWithPrefix(
                controller: _passwordController,
                hintText: 'Vul je wachtwoord in',
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(2)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              check ? check = false : check = true;
                            });
                          },
                          child: check
                              ? SizedBox(
                                  height: 15,
                                  width: 15,
                                )
                              : Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 15,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Onthoud \nmijn gegevens',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPasswordView()));
                      },
                      child: Text(
                        'Wachtwoord vergeten',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: signIn,
                        child: loading == true
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 1.5,
                                ),
                                height: 15.0,
                                width: 15.0,
                              )
                            : Text(
                                'Sign In',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nog geen account? ',
                    style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Signup_view()));
                    },
                    child: Text(
                      'Registreren',
                      style: GoogleFonts.inter(
                          color: Colors.greenAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    )),
                    Text(
                      ' Of log in met ',
                      style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                        ),
                        child: IconButton(
                            onPressed: () {
                              AuthServices.googleSignin();
                            },
                            // googleSignIn,
                            icon: Icon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                              size: 20,
                            ))),
                    // Container(
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.blue.shade100,
                    //     ),
                    //     child: IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           FontAwesomeIcons.apple,
                    //           color: Colors.black,
                    //         ))),
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                            )))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    FocusManager.instance.primaryFocus?.unfocus();
    loading = true;
    setState(() {});
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((value) => Get.to(Bottom_Nav_Bar(currentIndex: 0)))
        .catchError(() {
      print("here");
    });
  }

  googleSignIn() {
    GoogleSign sign = GoogleSign();
    sign.googleSignIn();
  }
}
