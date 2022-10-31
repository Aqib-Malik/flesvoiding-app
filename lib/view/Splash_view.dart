import 'package:firebase_auth/firebase_auth.dart';
import 'package:flesvoieding/constant/Constants.dart';
import 'package:flesvoieding/view/Login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Bottom_Nav_Bar.dart';
import 'Home_view.dart';

class Splash_view extends StatefulWidget {
  const Splash_view({Key,key}) : super(key: key);

  @override
  _Splash_viewState createState() => _Splash_viewState();
}

class _Splash_viewState extends State<Splash_view> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) => {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Change_View())),
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    sw=MediaQuery.of(context).size.width;
    sh=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: sh,
        width: sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Colors.yellow,
              Theme.of(context).primaryColor,
              Colors.yellow.shade800,
            ]
          )
        ),
        child: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("assets/images/splash.png"))),
          ),
        ),
      ),
    );
  }
}


class Change_View extends StatefulWidget {
  const Change_View({Key,key}) : super(key: key);

  @override
  _Change_ViewState createState() => _Change_ViewState();
}

class _Change_ViewState extends State<Change_View> {
  @override
  Widget build(BuildContext context) {
    sw=MediaQuery.of(context).size.width;
    sh=MediaQuery.of(context).size.height;
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Bottom_Nav_Bar(currentIndex: 0);
        }
        else{
          return Login_view();
        }
      }
    );
  }
}



