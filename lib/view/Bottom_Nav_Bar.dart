import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flesvoieding/commonWidgetss/CommonWidgets.dart';
import 'package:flesvoieding/controller/home_controller.dart';
import 'package:flesvoieding/view/Blog_view.dart';
import 'package:flesvoieding/view/Home_view.dart';
import 'package:flesvoieding/view/Setting_view.dart';
import 'package:flesvoieding/view/Weekly_overview_view.dart';
import 'package:flesvoieding/view/home/home.dart';
import 'package:flesvoieding/view/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home/homenew.dart';

class Bottom_Nav_Bar extends StatefulWidget {
  Bottom_Nav_Bar({Key, key, required this.currentIndex}) : super(key: key);

  int currentIndex = 0;

  @override
  _Bottom_Nav_BarState createState() => _Bottom_Nav_BarState();
}

class _Bottom_Nav_BarState extends State<Bottom_Nav_Bar> {
  final HomeController _logincontroller = Get.put(HomeController());
  Future<bool> _willPopCallback() async {
    CommonWidgets.confirmBox("Uitgang", "Weet u zeker dat u wilt afsluiten?",
        () {
      SystemNavigator.pop();
    });
    return true;
  }

  List pages = [
    Home(),
    // Home_view(),
    weeklyOverview_view(),
    Notes(),
    Blogs_view(),
    Settings_view()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: pages.elementAt(widget.currentIndex),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: widget.currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) =>
              setState(() => widget.currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.home),
              title: Text('Home'),
              activeColor: Colors.red,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(MdiIcons.chartBar),
              title: Text('Overzicht'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.noteSticky),
              title: Text(
                'Opmerkingen',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.blog),
              title: Text(
                'Blog',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Instellingen'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
