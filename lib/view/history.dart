import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flesvoieding/constant/Constants.dart';
import 'package:flesvoieding/controller/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:translator/translator.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../controller/home_controller.dart';

class History extends StatefulWidget {
  const History({Key, key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryController _controller = Get.put(HistoryController());
  // List result = [];
  // var tempDate = "";
  filerHistory() {
    // Get.find<HomeController>().milkData.where((p0) => false)

    _controller.historyData.value = Get.find<HomeController>()
        .milkData
        .where((o) =>
            o['dateTime'].toDate().toString().substring(0, 11) ==
            _controller.tempDate.value)
        .toList();

    print("zzzzzzzzzzzzzzzzz" + _controller.historyData.toString());
  }

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  int formattedDate = int.parse(DateFormat('ddMMyyyy').format(DateTime.now()));
  final translator = GoogleTranslator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 70,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1)),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.black,
              ),
            ),
          ),
          title: InkWell(
            onTap: () {
              filerHistory();
            },
            child: Text(
              'Melk geschiedenis',
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        body: Obx(
          () => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Get.width / 1.6,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                      ),
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inDays.toString());
                        }, onConfirm: (date) {
                          print('confirm $date');
                          print(
                            date.toString().substring(0, 11),
                          );

                          _controller.tempDate.value =
                              date.toString().substring(0, 11);
                          filerHistory();
                        }, currentTime: DateTime.now(), locale: LocaleType.nl);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Selecteer een datum'),
                          Icon(Icons.search)
                        ],
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    // height: Get.height / 1.7,
                    width: sw * 0.9,
                    color: Colors.transparent,
                    child: _controller.historyData.isEmpty
                        ? ListView.separated(
                            separatorBuilder: ((context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            }),
                            itemCount:
                                Get.find<HomeController>().milkData.length,
                            itemBuilder: (context, index) {
                              DateFormat dateFormat = DateFormat("hh:mm a");
                              String milkTime = dateFormat.format(
                                  Get.find<HomeController>()
                                      .milkData[index]['dateTime']
                                      .toDate());
                              return Container(
                                width: sw * 0.9,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xfffffbe0),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(MdiIcons.history),
                                        Text(
                                          Get.find<HomeController>()
                                              .milkData[index]['dateTime']
                                              .toDate()
                                              .toString()
                                              .substring(0, 11),
                                          // milkTime,
                                          style: GoogleFonts.dmSans(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(MdiIcons.clockOutline),
                                            Text(
                                              " " + milkTime.toString(),
                                              // milkTime,
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
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
                                        //     percent: double.parse(
                                        //             Get.find<HomeController>()
                                        //                 .milkData[index]['milkVal']) /
                                        //         200,
                                        //     progressColor:
                                        //         Theme.of(context).primaryColor,
                                        //     backgroundColor: Colors.white,
                                        //   ),
                                        // ),
                                        Row(
                                          children: [
                                            Icon(MdiIcons.babyBottleOutline),
                                            Text(
                                              (' ' +
                                                      Get.find<HomeController>()
                                                              .milkData[index]
                                                          ['milkVal']) +
                                                  "mL",
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),

                                            // Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : ListView.separated(
                            separatorBuilder: ((context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            }),
                            itemCount: _controller.historyData.length,
                            itemBuilder: (context, index) {
                              DateFormat dateFormat = DateFormat("hh:mm a");
                              String milkTime = dateFormat.format(_controller
                                  .historyData[index]['dateTime']
                                  .toDate());
                              return Container(
                                width: sw * 0.9,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xfffffbe0),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(MdiIcons.history),
                                        Text(
                                          _controller.historyData[index]
                                                  ['dateTime']
                                              .toDate()
                                              .toString()
                                              .substring(0, 11),
                                          // milkTime,
                                          style: GoogleFonts.dmSans(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(MdiIcons.clockOutline),
                                            Text(
                                              " " + milkTime.toString(),
                                              // milkTime,
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
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
                                        //     percent: double.parse(
                                        //             Get.find<HomeController>()
                                        //                 .milkData[index]['milkVal']) /
                                        //         200,
                                        //     progressColor:
                                        //         Theme.of(context).primaryColor,
                                        //     backgroundColor: Colors.white,
                                        //   ),
                                        // ),
                                        Row(
                                          children: [
                                            Icon(MdiIcons.babyBottleOutline),
                                            Text(
                                              (' ' +
                                                      _controller.historyData[
                                                          index]['milkVal']) +
                                                  "mL",
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),

                                            // Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();

    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  getDay(uploadDatee) async {
    DateTime dateTime = uploadDatee;
    var day;

    if ((dateTime.day == (DateTime.now().day)) &&
        (dateTime.month == DateTime.now().month) &&
        (dateTime.year == DateTime.now().year)) {
      return "Vandaag";
    } else {
      day = DateFormat('EEEE').format(dateTime).toString();
      print(day);
      day = await translator.translate(day, to: 'nl');
      return day;
    }
  }
}































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flesvoieding/constant/Constants.dart';
// import 'package:flesvoieding/view/Bottom_Nav_Bar.dart';
// import 'package:flesvoieding/view/Home_view.dart';
// import 'package:flesvoieding/view/Signup_view.dart';
// import 'package:flesvoieding/widgets/text_fields.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:translator/translator.dart';


// class History extends StatefulWidget {
//   const History({Key, key}) : super(key: key);

//   @override
//   _HistoryState createState() => _HistoryState();
// }

// class _HistoryState extends State<History> {

//   var currentUser = FirebaseAuth.instance.currentUser;
//   CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');
//   int formattedDate = int.parse(DateFormat('ddMMyyyy').format(DateTime.now()));
//   final translator = GoogleTranslator();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 70,
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: Container(
//           margin: EdgeInsets.symmetric(vertical: 5),
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.black, width: 1)),
//           child: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios_sharp,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         title: Text(
//           'Melk geschiedenis',
//           style: GoogleFonts.inter(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 20,),
//           StreamBuilder<QuerySnapshot>(
//               stream:FirebaseFirestore.instance
//                   .collection('users').doc(currentUser!.uid).collection('milk').where('uploadDateDayMonth', isGreaterThanOrEqualTo: formattedDate)
//                   .snapshots(),
//               builder: (context, snapshots) {
//                 if(snapshots.hasData){
//                   return Expanded(
//                     child: ListView(
//                       shrinkWrap: true,
//                       children: snapshots.data!.docs.map((document) {
//                         return FutureBuilder(
//                             future: getDay(document['uploadDate'].toDate()),
//                             builder: (context, snapshot) {
//                               if(snapshot.hasData){
//                                 return Column(
//                                   children: [
//                                     Container(
//                                       width:sw * 0.92,
//                                       padding: EdgeInsets.all(5),
//                                       margin: EdgeInsets.symmetric(vertical: 10),
//                                       decoration: BoxDecoration(
//                                         color: Color(0xfffffbe0),
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             snapshot.data.toString(),
//                                             style: GoogleFonts.dmSans(
//                                                 fontSize: 18, fontWeight: FontWeight.w500),
//                                           ),
//                                           Container(
//                                             height: 20,
//                                             width: 100,
//                                             child: LinearPercentIndicator(
//                                               width: 100.0,
//                                               lineHeight: 20.0,
//                                               barRadius: Radius.circular(20),
//                                               percent: (document['milkConsumed'] / document['maxMilk']),
//                                               progressColor:Theme.of(context).primaryColor,
//                                               backgroundColor:Colors.white,
//                                             ),
//                                           ),
//                                           Row(
//                                             children: [
//                                               Icon(MdiIcons.babyBottleOutline),
//                                               Text(
//                                                 " ${document['milkConsumed']}/${document['maxMilk']} Flessen",
//                                                 style: GoogleFonts.dmSans(
//                                                     fontSize: 18, fontWeight: FontWeight.w500),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),

//                                     SizedBox(height: 5,),

//                                     Container(
//                                       height: 140,
//                                       width:sw * 0.9,
//                                       color: Colors.transparent,
//                                       child: ListView.separated(
//                                         separatorBuilder: ((context, index) {
//                                           return SizedBox(height: 20,);
//                                         }),
//                                         itemCount: document['totalMilk'].length,
//                                         itemBuilder: (context, index){
//                                           DateFormat dateFormat = DateFormat("hh:mm a");
//                                           String milkTime = dateFormat.format(document['totalMilk'][index]['time'].toDate());

//                                           return Container(
//                                             width:sw * 0.9,
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                               color: Color(0xfffffbe0),
//                                               borderRadius: BorderRadius.circular(50),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Icon(MdiIcons.clockOutline),
//                                                     Text(
//                                                       " " + milkTime,
//                                                       style: GoogleFonts.dmSans(
//                                                           fontSize: 18, fontWeight: FontWeight.w500),
//                                                     ),
//                                                   ],
//                                                 ),

//                                                 Row(
//                                                   children: [
//                                                     Icon(MdiIcons.babyBottleOutline),
//                                                     Text(
//                                                       (' ' + document['totalMilk'][index]['litres'].toString() + ' Flessen'),
//                                                       style: GoogleFonts.dmSans(
//                                                           fontSize: 18, fontWeight: FontWeight.w500),
//                                                     ),
//                                                     Icon(Icons.arrow_forward_ios),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 10,),
//                                   ],
//                                 );
//                               } else
//                                 return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));

//                             }
//                         );
//                       }).toList(),
//                     ),
//                   );
//                 }else
//                   return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
//               }

//           ),
//           SizedBox(height: 20,),
//         ],
//       ),
//     );
//   }

//   getDay(uploadDatee) async{
//     DateTime dateTime = uploadDatee;
//     var day;

//     if((dateTime.day == (DateTime.now().day)) && (dateTime.month == DateTime.now().month) && (dateTime.year == DateTime.now().year)){
//       return "Vandaag";
//     } else {
//       day = DateFormat('EEEE').format(dateTime).toString();
//       print(day);
//       day = await translator.translate(day, to: 'nl');
//       return day;
//     }
//   }


// }
