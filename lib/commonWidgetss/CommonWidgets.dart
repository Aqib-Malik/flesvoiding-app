import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fluttertoast/fluttertoast.dart';

class CommonWidgets {
  ////////////////////*************DialogBox */
  static confirmBox(String titlle, String texte, VoidCallback click) {
    return Get.defaultDialog(
        title: titlle,
        middleText: texte, //"Are you sure you want to delete this user?",
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.amber,
                    )),
                    child: const Text(
                      'annuleren',
                      // ignore: unnecessary_const
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      click();
                      Get.back();
                      // AuthServices.deleteAccount(email);
                      //Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.red,
                    )),
                    child: Text(
                      titlle,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          )
        ]);
  }

  ///Tost
  static void toastShow(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
