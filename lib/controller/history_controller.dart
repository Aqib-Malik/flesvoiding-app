// ignore_for_file: non_constant_identifier_names, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var historyData = [].obs;
  var tempDate = "".obs;

  @override
  void onInit() async {
    super.onInit();
  }
}
