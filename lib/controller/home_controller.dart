// ignore_for_file: non_constant_identifier_names, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var milkData = [].obs;
  RxString name = "Name".obs;
  var email = "".obs;
  // var milkDataMap = {}.obs;
  Map? data;
////fetching data
  fetchdata() {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection //(teach == false? 'students': 'users');
        ('users');

    collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      data = snapshot.data() as Map?;
      print(data.toString());
      if (data != null) {
        // CommonWdget.confirmBox("titlle", data.toString(), () { });
        name.value = data!['name'];
        email.value = data!['email'];
        // milkDataMap.value = data!['milk'];
        data!['today_milk'] == null
            ? milkData.value = []
            : milkData.value = data!['today_milk'];
      } else {
        name.value = "";
        email.value = "";
        // milkDataMap.value = {};
        milkData.value = [];
      }
    });
  }

  @override
  void onClose() {}

  @override
  void onInit() async {
    await fetchdata();

    super.onInit();
  }
}
