import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flesvoieding/commonWidgetss/CommonWidgets.dart';
import 'package:flesvoieding/controller/home_controller.dart';
import 'package:flesvoieding/view/Bottom_Nav_Bar.dart';
import 'package:get/get.dart';

class FirestoreMethods {
  static createUserInFireStore(String id, var userData) async {
    await FirebaseFirestore.instance.collection('users').doc(id).set(userData);
  }

  /////update milk
  static void updateMilk(data) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'milk': data,
    }).whenComplete(() {
      CommonWidgets.toastShow("milk updated Successfully");
    });
  }

  //****Update updateMilkValue on firebasae******/
  static void updateMilkValue(var milkData) async {
    print(
        "(((((((((((((((((((((((((((((((((((((object)))))))))))))))))))))))))))))))))))))");
    var list = [milkData];
    //followers = followers++;
    print("|||||||||||||||||||||||||||||||||||||");
    print(milkData);
    // if (Get.find<HomeController>().milkData.isEmpty) {
    //   print("""""" """""" """""" """""object""" """""" """""" """""" "");
    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .update({"today_milk": list}
    //           //   {
    //           //   "followers": followers,
    //           // }
    //           ).whenComplete(() => CommonWidgets.toastShow("toegevoegd"));
    // } else {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"today_milk": FieldValue.arrayUnion(list)}
            //   {
            //   "followers": followers,
            // }
            ).whenComplete(() {
      CommonWidgets.toastShow("toegevoegd");
    });
    // .then((value) => Get.off(Bottom_Nav_Bar(currentIndex: 0)));
  }
  //}
}
