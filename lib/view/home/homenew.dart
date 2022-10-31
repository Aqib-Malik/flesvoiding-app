import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flesvoieding/commonWidgetss/CommonWidgets.dart';
import 'package:flesvoieding/constant/Constants.dart';
import 'package:flesvoieding/controller/home_controller.dart';
import 'package:flesvoieding/model/userProfileModel.dart';
import 'package:flesvoieding/services/firebase_servises/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

class Home extends StatefulWidget {
  const Home({Key, key}) : super(key: key);

  @override
  _Home_viewState createState() => _Home_viewState();
}

class _Home_viewState extends State<Home> {
  final formkey1 = GlobalKey<FormState>();
  TextEditingController milMlController = TextEditingController();
  var totalMilk = 0;
  DateTime? uploadGate;
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  final translator = GoogleTranslator();
  int formattedDate = int.parse(DateFormat('ddMMyyyy').format(DateTime.now()));

  countMilk() {
    print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    print(Get.find<HomeController>().milkData);
    for (var i = 0; i < Get.find<HomeController>().milkData.length; i++) {
      print("***************");
      print(i);
      print("***************");
    }
    // Get.find<HomeController>().milkData.value.forEach((element) {
    //   print("***************");
    //   print(element);
    //   print("***************");
    // });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    countMilk();
    print(formattedDate);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        floatingActionButton: InkWell(
          onTap: () {
            print(checkDate("2022-09-29"));
            milkBottomSheet();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: FutureBuilder<dynamic>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DateTime currentDate = DateTime.now();
                    final date2 = DateTime.now();
                    final difference = date2
                        .difference(snapshot.data['birthDate'].toDate())
                        .inDays;

                    var weeks = (difference / 7).toInt();
                    var days = difference % 7;

                    return Column(
                      children: [
                        SizedBox(
                          height: sh * 0.05,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              width: sw * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hallo,',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data['name'],
                                    style: GoogleFonts.dmSans(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '$weeks weeks $days days',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: sh * 0.2,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/home.png'),
                                        fit: BoxFit.fill)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx((() => MilkWdget())),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    );
                  }
                }),
          ),
        ));

    // Obx(() => MilkWdget()));
  }

  MilkWdget() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return Column(
      children: [
        Container(
          width: sw * 0.92,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xfffffbe0),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Today ",
                    style: GoogleFonts.dmSans(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatted,
                    style: GoogleFonts.dmSans(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: Get.height / 2.3,
          width: sw * 0.9,
          color: Colors.transparent,
          child: ListView.separated(
            separatorBuilder: ((context, index) {
              return SizedBox(
                height: 20,
              );
            }),
            itemCount: Get.find<HomeController>().milkData.length,
            itemBuilder: (context, index) {
              totalMilk = totalMilk +
                  int.parse(
                      Get.find<HomeController>().milkData[index]['milkVal']);
              print(totalMilk);
              DateFormat dateFormat = DateFormat("hh:mm a");
              String milkTime = dateFormat.format(Get.find<HomeController>()
                  .milkData[index]['dateTime']
                  .toDate());
              return isToday(Get.find<HomeController>()
                      .milkData[index]['dateTime']
                      .toDate())
                  ? Container(
                      width: sw * 0.9,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xfffffbe0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(MdiIcons.clockOutline),
                              Text(
                                " " + milkTime.toString(),
                                // milkTime,
                                style: GoogleFonts.dmSans(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          // Container(
                          //   height: 20,
                          //   width: 100,
                          //   child: LinearPercentIndicator(
                          //     width: 100.0,
                          //     lineHeight: 20.0,
                          //     barRadius: Radius.circular(20),
                          //     percent: double.parse(Get.find<HomeController>()
                          //             .milkData[index]['milkVal']) /
                          //         200,
                          //     progressColor: Theme.of(context).primaryColor,
                          //     backgroundColor: Colors.white,
                          //   ),
                          // ),
                          Row(
                            children: [
                              Icon(MdiIcons.babyBottleOutline),
                              Text(
                                (' ' +
                                        Get.find<HomeController>()
                                            .milkData[index]['milkVal']) +
                                    "mL",
                                style: GoogleFonts.dmSans(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),

                              // Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ],
                      ),
                    )
                  : SizedBox();
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  ////KidTalkbottomSheet
  milkBottomSheet() {
    return Get.bottomSheet(
        SingleChildScrollView(
          child: Container(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        ),
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            uploadGate = date;
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.nl);
                        },
                        child: Text('Datum en tijd')),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Hoeveelheid (ml)', // 'Totaal melk Flessen',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: formkey1,
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.6,
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(25),
                          //     border: Border.all(
                          //         color: Colors.grey.shade300, width: 1)),
                          child: TextFormField(
                            validator: (value) {
                              if (int.parse(value!) > 250 ||
                                  int.parse(value) == 0 ||
                                  value.isEmpty) {
                                return 'enter valid value';
                              }
                              return null;
                            },
                            controller: milMlController,
                            keyboardType: TextInputType.number,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                onPressed: () async {
                                  //   Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
                                  //  DateTime myDateTime = myTimeStamp.toDate();
                                  // print(isToday(Get.find<HomeController>()
                                  //     .milkData[0]['dateTime']
                                  //     .toDate()));
                                  // print(Get.find<HomeController>()
                                  //         .milkData[0]['dateTime']
                                  //         .toDate()
                                  //     // .last['dateTime']
                                  //     // .toDate()
                                  //     // Get.find<HomeController>()
                                  //     //   .milkData[0]['dateTime']
                                  //     //   .toDate())
                                  //     );
                                  if (uploadGate == null) {
                                    CommonWidgets.toastShow(
                                        "Please select date first");
                                  } else if (formkey1.currentState!
                                      .validate()) {
                                    // int total_milk = Get.find<HomeController>()
                                    //         .milkData
                                    //         .last['total_mlk'] +
                                    //     int.parse(milMlController.text);
                                    // // await searchMilkDate();
                                    // print(total_milk);
                                    // if (total_milk >= 250) {
                                    //   CommonWidgets.toastShow("Limit exceed");
                                    // }
                                    // else {
                                    //   final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');
                                    //  print(moonLanding.year);
                                    var milData = {
                                      "milkVal": milMlController.text,
                                      "dateTime": uploadGate,
                                      "today": DateTime.now(),
                                      // "total_mlk": Get.find<HomeController>()
                                      //         .milkData
                                      //         .isEmpty
                                      //     ? int.parse(milMlController.text)
                                      //     : total_milk
                                    };
                                    FirestoreMethods.updateMilkValue(milData);
                                    milMlController.clear();
                                    Get.back();
                                  }
                                  // }
                                },
                                child: Text(
                                  'Voeg fles toe',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
        elevation: 20.0,
        enableDrag: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        )));
  }

  getData() async {
    var temp = await collectionReference.doc(currentUser!.uid).get();
    return temp;
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();

    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  checkDate(String dateString) {
    //  example, dateString = "2020-01-26";

    DateTime checkedTime = DateTime.parse(dateString);
    DateTime currentTime = DateTime.now();

    if ((currentTime.year == checkedTime.year) &&
        (currentTime.month == checkedTime.month) &&
        (currentTime.day == checkedTime.day)) {
      return "TODAY";
    } else if ((currentTime.year == checkedTime.year) &&
        (currentTime.month == checkedTime.month)) {
      if ((currentTime.day - checkedTime.day) == 1) {
        return "YESTERDAY";
      } else if ((currentTime.day - checkedTime.day) == -1) {
        return "TOMORROW";
      } else {
        return dateString;
      }
    }
  }
}

// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flesvoieding/commonWidgetss/CommonWidgets.dart';
// import 'package:flesvoieding/constant/Constants.dart';
// import 'package:flesvoieding/controller/home_controller.dart';
// import 'package:flesvoieding/model/userProfileModel.dart';
// import 'package:flesvoieding/services/firebase_servises/firestore_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:intl/intl.dart';
// import 'package:translator/translator.dart';

// class Home extends StatefulWidget {
//   const Home({Key, key}) : super(key: key);

//   @override
//   _Home_viewState createState() => _Home_viewState();
// }

// class _Home_viewState extends State<Home> {
//   final formkey1 = GlobalKey<FormState>();
//   TextEditingController milMlController = TextEditingController();
//   var totalMilk = 0;
//   var currentUser = FirebaseAuth.instance.currentUser;
//   CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('users');
//   final translator = GoogleTranslator();
//   int formattedDate = int.parse(DateFormat('ddMMyyyy').format(DateTime.now()));

//   countMilk() {
//     print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
//     print(Get.find<HomeController>().milkData);
//     for (var i = 0; i < Get.find<HomeController>().milkData.length; i++) {
//       print("***************");
//       print(i);
//       print("***************");
//     }
//     // Get.find<HomeController>().milkData.value.forEach((element) {
//     //   print("***************");
//     //   print(element);
//     //   print("***************");
//     // });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     countMilk();
//     print(formattedDate);
//     return Scaffold(
//         // resizeToAvoidBottomInset: false,
//         floatingActionButton: InkWell(
//           onTap: () {
//             milkBottomSheet();
//           },
//           child: Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Theme.of(context).primaryColor,
//             ),
//             child: Icon(
//               Icons.add,
//               color: Colors.white,
//               size: 30,
//             ),
//           ),
//         ),
//         body: FutureBuilder<dynamic>(
//             future: getData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 DateTime currentDate = DateTime.now();
//                 final date2 = DateTime.now();
//                 final difference = date2
//                     .difference(snapshot.data['birthDate'].toDate())
//                     .inDays;

//                 var weeks = (difference / 7).toInt();
//                 var days = difference % 7;

//                 return Column(
//                   children: [
//                     SizedBox(
//                       height: sh * 0.05,
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(20),
//                           width: sw * 0.5,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Hallo,',
//                                 style: GoogleFonts.dmSans(
//                                     fontSize: 30, fontWeight: FontWeight.w500),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Text(
//                                 snapshot.data['name'],
//                                 style: GoogleFonts.dmSans(
//                                     fontSize: 48, fontWeight: FontWeight.w700),
//                               ),
//                               Text(
//                                 '$weeks weeks $days days',
//                                 style: GoogleFonts.dmSans(
//                                     fontSize: 13, fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             height: sh * 0.2,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage('assets/images/home.png'),
//                                     fit: BoxFit.fill)),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Obx((() => MilkWdget())),
//                   ],
//                 );
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(
//                       color: Theme.of(context).primaryColor),
//                 );
//               }
//             }));

//     // Obx(() => MilkWdget()));
//   }

//   MilkWdget() {
//     final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     final String formatted = formatter.format(now);
//     return Column(
//       children: [
//         Container(
//           width: sw * 0.92,
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: Color(0xfffffbe0),
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     "Today ",
//                     style: GoogleFonts.dmSans(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     formatted,
//                     style: GoogleFonts.dmSans(
//                         fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Container(
//           height: Get.height / 4,
//           width: sw * 0.9,
//           color: Colors.transparent,
//           child: ListView.separated(
//             separatorBuilder: ((context, index) {
//               return SizedBox(
//                 height: 20,
//               );
//             }),
//             itemCount: Get.find<HomeController>().milkData.length,
//             itemBuilder: (context, index) {
//               totalMilk = totalMilk +
//                   int.parse(
//                       Get.find<HomeController>().milkData[index]['milkVal']);
//               print(totalMilk);
//               DateFormat dateFormat = DateFormat("hh:mm a");
//               String milkTime = dateFormat.format(Get.find<HomeController>()
//                   .milkData[index]['dateTime']
//                   .toDate());
//               return Container(
//                 width: sw * 0.9,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Color(0xfffffbe0),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(MdiIcons.clockOutline),
//                         Text(
//                           " " + milkTime.toString(),
//                           // milkTime,
//                           style: GoogleFonts.dmSans(
//                               fontSize: 18, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       height: 20,
//                       width: 100,
//                       child: LinearPercentIndicator(
//                         width: 100.0,
//                         lineHeight: 20.0,
//                         barRadius: Radius.circular(20),
//                         percent: double.parse(Get.find<HomeController>()
//                                 .milkData[index]['milkVal']) /
//                             200,
//                         progressColor: Theme.of(context).primaryColor,
//                         backgroundColor: Colors.white,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Icon(MdiIcons.babyBottleOutline),
//                         Text(
//                           (' ' +
//                                   Get.find<HomeController>().milkData[index]
//                                       ['milkVal']) +
//                               "mL",
//                           style: GoogleFonts.dmSans(
//                               fontSize: 18, fontWeight: FontWeight.w500),
//                         ),

//                         // Icon(Icons.arrow_forward_ios),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//       ],
//     );
//   }

//   ////KidTalkbottomSheet
//   milkBottomSheet() {
//     return Get.bottomSheet(
//         SingleChildScrollView(
//           child: Container(
//             child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.amber),
//                         ),
//                         onPressed: () {
//                           DatePicker.showDateTimePicker(context,
//                               showTitleActions: true, onChanged: (date) {
//                             print('change $date in time zone ' +
//                                 date.timeZoneOffset.inHours.toString());
//                           }, onConfirm: (date) {
//                             print('confirm $date');
//                           },
//                               currentTime: DateTime(2008, 12, 31, 23, 12, 34),
//                               locale: LocaleType.nl);
//                         },
//                         child: Text('Datum en tijd')),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Hoeveelheid (ml)', // 'Totaal melk Flessen',
//                       style: GoogleFonts.inter(
//                           fontSize: 14, fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Form(
//                       key: formkey1,
//                       child: Container(
//                           height: 40,
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           // decoration: BoxDecoration(
//                           //     borderRadius: BorderRadius.circular(25),
//                           //     border: Border.all(
//                           //         color: Colors.grey.shade300, width: 1)),
//                           child: TextFormField(
//                             validator: (value) {
//                               if (int.parse(value!) > 250 ||
//                                   int.parse(value) == 0 ||
//                                   value.isEmpty) {
//                                 return 'enter valid value';
//                               }
//                               return null;
//                             },
//                             controller: milMlController,
//                             keyboardType: TextInputType.number,
//                           )),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Theme.of(context).primaryColor,
//                                     padding: EdgeInsets.all(10),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(5))),
//                                 onPressed: () async {
//                                   if (formkey1.currentState!.validate()) {
//                                     int total_milk = Get.find<HomeController>()
//                                             .milkData
//                                             .last['total_mlk'] +
//                                         int.parse(milMlController.text);
//                                     // await searchMilkDate();
//                                     print(total_milk);

//                                     FirestoreMethods.updateMilkValue({
//                                       "milkVal": milMlController.text,
//                                       "dateTime": Timestamp.now(),
//                                       // "total_mlk": Get.find<HomeController>()
//                                       //         .milkData
//                                       //         .isEmpty
//                                       //     ? int.parse(milMlController.text)
//                                       //     : total_milk
//                                     });
//                                   }
//                                 },
//                                 child: Text(
//                                   'Voeg fles toe',
//                                   style: GoogleFonts.inter(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500),
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ),
//         elevation: 20.0,
//         enableDrag: false,
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30.0),
//           topRight: Radius.circular(30.0),
//         )));
//   }

//   getData() async {
//     var temp = await collectionReference.doc(currentUser!.uid).get();
//     return temp;
//   }
// }
