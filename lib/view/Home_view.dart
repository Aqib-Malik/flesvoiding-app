// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flesvoieding/constant/Constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:translator/translator.dart';

// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// class Home_view extends StatefulWidget {
//   const Home_view({Key, key}) : super(key: key);

//   @override
//   _Home_viewState createState() => _Home_viewState();
// }

// class _Home_viewState extends State<Home_view> {
//   TextEditingController milMlController = TextEditingController();
//   var currentUser = FirebaseAuth.instance.currentUser;
//   CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('users');
//   final translator = GoogleTranslator();
//   int formattedDate = int.parse(DateFormat('ddMMyyyy').format(DateTime.now()));

//   @override
//   Widget build(BuildContext context) {
//     print(formattedDate);
//     return Scaffold(
//         floatingActionButton: InkWell(
//           onTap: () {
//             showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return addMilk_Dialog();
//                 });
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
//                     StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(currentUser!.uid)
//                             .collection('milk')
//                             .where('uploadDateDayMonth',
//                                 isGreaterThanOrEqualTo: formattedDate)
//                             .snapshots(),
//                         builder: (context, snapshots) {
//                           if (snapshots.hasData) {
//                             return Expanded(
//                               child: ListView(
//                                 children: snapshots.data!.docs.map((document) {
//                                   return FutureBuilder(
//                                       future: getDay(
//                                           document['uploadDate'].toDate()),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.hasData) {
//                                           return Column(
//                                             children: [
//                                               Container(
//                                                 width: sw * 0.92,
//                                                 padding: EdgeInsets.all(10),
//                                                 margin: EdgeInsets.symmetric(
//                                                     vertical: 10),
//                                                 decoration: BoxDecoration(
//                                                   color: Color(0xfffffbe0),
//                                                   borderRadius:
//                                                       BorderRadius.circular(50),
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                       snapshot.data.toString(),
//                                                       style: GoogleFonts.dmSans(
//                                                           fontSize: 18,
//                                                           fontWeight:
//                                                               FontWeight.w500),
//                                                     ),
//                                                     // Container(
//                                                     //   height: 20,
//                                                     //   width: 100,
//                                                     //   child:
//                                                     //       LinearPercentIndicator(
//                                                     //     width: 100.0,
//                                                     //     lineHeight: 20.0,
//                                                     //     barRadius:
//                                                     //         Radius.circular(20),
//                                                     //     percent: (document[
//                                                     //             'milkConsumed'] /
//                                                     //         document[
//                                                     //             'maxMilk']),
//                                                     //     progressColor:
//                                                     //         Theme.of(context)
//                                                     //             .primaryColor,
//                                                     //     backgroundColor:
//                                                     //         Colors.white,
//                                                     //   ),
//                                                     // ),
//                                                     // Row(
//                                                     //   children: [
//                                                     //     Icon(MdiIcons
//                                                     //         .babyBottleOutline),
//                                                     //     Text(
//                                                     //       " ${document['milkConsumed']}/${document['maxMilk']} Flessen",
//                                                     //       style: GoogleFonts
//                                                     //           .dmSans(
//                                                     //               fontSize: 18,
//                                                     //               fontWeight:
//                                                     //                   FontWeight
//                                                     //                       .w500),
//                                                     //     ),
//                                                     //   ],
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Container(
//                                                 height: 140,
//                                                 width: sw * 0.9,
//                                                 color: Colors.transparent,
//                                                 child: ListView.separated(
//                                                   separatorBuilder:
//                                                       ((context, index) {
//                                                     return SizedBox(
//                                                       height: 20,
//                                                     );
//                                                   }),
//                                                   itemCount:
//                                                       document['totalMilk']
//                                                           .length,
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     DateFormat dateFormat =
//                                                         DateFormat("hh:mm a");
//                                                     String milkTime = dateFormat
//                                                         .format(document[
//                                                                     'totalMilk']
//                                                                 [index]['time']
//                                                             .toDate());

//                                                     return Container(
//                                                       width: sw * 0.9,
//                                                       padding:
//                                                           EdgeInsets.all(10),
//                                                       decoration: BoxDecoration(
//                                                         color:
//                                                             Color(0xfffffbe0),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(50),
//                                                       ),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Row(
//                                                             children: [
//                                                               Icon(MdiIcons
//                                                                   .clockOutline),
//                                                               Text(
//                                                                 " " + milkTime,
//                                                                 style: GoogleFonts.dmSans(
//                                                                     fontSize:
//                                                                         18,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w500),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           Row(
//                                                             children: [
//                                                               Icon(MdiIcons
//                                                                   .babyBottleOutline),
//                                                               Text(
//                                                                 (' ' +
//                                                                     document['totalMilk'][index]
//                                                                             [
//                                                                             'litres']
//                                                                         .toString() +
//                                                                     ' Flessen'),
//                                                                 style: GoogleFonts.dmSans(
//                                                                     fontSize:
//                                                                         18,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w500),
//                                                               ),
//                                                               Icon(Icons
//                                                                   .arrow_forward_ios),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 10,
//                                               ),
//                                             ],
//                                           );
//                                         } else
//                                           return Center(
//                                               child: CircularProgressIndicator(
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                           ));
//                                       });
//                                 }).toList(),
//                               ),
//                             );
//                           } else {
//                             return Center(
//                                 child: CircularProgressIndicator(
//                               color: Theme.of(context).primaryColor,
//                             ));
//                           }
//                         })
//                   ],
//                 );
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(
//                       color: Theme.of(context).primaryColor),
//                 );
//               }
//             }));
//   }

//   getData() async {
//     var temp = await collectionReference.doc(currentUser!.uid).get();
//     return temp;
//   }

//   getDay(uploadDatee) async {
//     DateTime dateTime = uploadDatee;
//     var day;

//     if ((dateTime.day == (DateTime.now().day)) &&
//         (dateTime.month == DateTime.now().month) &&
//         (dateTime.year == DateTime.now().year)) {
//       return "Vandaag";
//     } else {
//       day = DateFormat('EEEE').format(dateTime).toString();
//       print(day);
//       day = await translator.translate(day, to: 'nl');
//       return day;
//     }
//   }
// }

// class addMilk_Dialog extends StatefulWidget {
//   const addMilk_Dialog({Key, key}) : super(key: key);

//   @override
//   _addMilk_DialogState createState() => _addMilk_DialogState();
// }

// class _addMilk_DialogState extends State<addMilk_Dialog> {
//   final formkey1 = GlobalKey<FormState>();
//   TextEditingController milMlController = TextEditingController();
//   var uploadDate;
//   // TextEditingController _milkController = new TextEditingController();
//   // TextEditingController _totalMilkController = new TextEditingController();

//   var currentUser = FirebaseAuth.instance.currentUser;
//   int dropdownTotalMilk = 1;
//   int dropdownTempMilk = 1;
//   int formattedDate =
//       int.parse(DateFormat('dMMyyyy').format(DateTime.now()).toString());

//   // List of items in our dropdown menu
//   var milk = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

//   @override
//   Widget build(BuildContext context) {
//     print(formattedDate);
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUser!.uid)
//             .collection('milk')
//             .where('uploadDateDayMonth', isEqualTo: formattedDate)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             print("hereeeeeeeeeeeeeee");
//             print(snapshot.data!.docs.length.toString());
//             if (snapshot.data!.docs.length == 0) {
//               return Container(
//                 height: Get.height / 2.3,
//                 width: sw,
//                 padding: EdgeInsets.all(10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
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

//                     // Text(
//                     //   'Datum en tijd',
//                     //   style: GoogleFonts.inter(
//                     //       fontSize: 14, fontWeight: FontWeight.w600),
//                     // ),
//                     // SizedBox(
//                     //   height: 10,
//                     // ),
//                     // DateTimePicker(
//                     //   type: DateTimePickerType.dateTimeSeparate,
//                     //   dateMask: 'd MMM, yyyy',
//                     //   firstDate: DateTime(2000),
//                     //   lastDate: DateTime(2100),
//                     //   icon: Icon(Icons.event),
//                     //   dateLabelText: 'Date',
//                     //   timeLabelText: "Hour",
//                     //   selectableDayPredicate: (date) {
//                     //     // Disable weekend days to select from the calendar
//                     //     return true;
//                     //   },
//                     //   onChanged: (val) => uploadDate = DateTime.parse(val),
//                     //   validator: (val) {
//                     //     print(val);
//                     //     return null;
//                     //   },
//                     //   onSaved: (val) => print("Saved" + val.toString()),
//                     // ),
//                     // SizedBox(
//                     //   height: 10,
//                     // ),
//                     // Text(
//                     //   'Flessen',
//                     //   style: GoogleFonts.inter(
//                     //       fontSize: 14, fontWeight: FontWeight.w600),
//                     // ),
//                     // SizedBox(
//                     //   height: 10,
//                     // ),
//                     // Container(
//                     //   height: 40,
//                     //   width: MediaQuery.of(context).size.width * 0.3,
//                     //   decoration: BoxDecoration(
//                     //       borderRadius: BorderRadius.circular(25),
//                     //       border: Border.all(
//                     //           color: Colors.grey.shade300, width: 1)),
//                     //   child: DropdownButtonHideUnderline(
//                     //     child: DropdownButton<int>(
//                     //       // Initial Value
//                     //       value: dropdownTempMilk,
//                     //       // Down Arrow Icon
//                     //       icon: const Icon(Icons.arrow_drop_down_outlined),
//                     //       // Array list of items
//                     //       items: milk.map((int items) {
//                     //         return DropdownMenuItem(
//                     //           value: items,
//                     //           child: Row(
//                     //             mainAxisAlignment:
//                     //                 MainAxisAlignment.spaceEvenly,
//                     //             children: [
//                     //               SizedBox(
//                     //                 width: 10,
//                     //               ),
//                     //               Icon(
//                     //                 MdiIcons.babyBottleOutline,
//                     //                 color: Colors.grey,
//                     //               ),
//                     //               SizedBox(
//                     //                 width: 5,
//                     //               ),
//                     //               Text(
//                     //                 items.toString(),
//                     //                 style: TextStyle(
//                     //                     fontFamily: 'SFProText',
//                     //                     fontWeight: FontWeight.w500,
//                     //                     fontSize: 13,
//                     //                     color: Colors.black),
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         );
//                     //       }).toList(),
//                     //       // After selecting the desired option,it will
//                     //       // change button value to selected value
//                     //       onChanged: (int? newValue) {
//                     //         setState(() {
//                     //           dropdownTempMilk = newValue!;
//                     //         });
//                     //       },
//                     //     ),
//                     //   ),
//                     // ),
//                     // SizedBox(
//                     //   height: 10,
//                     // ),
//                     // Text(
//                     //   'Totaal melk Flessen',
//                     //   style: GoogleFonts.inter(
//                     //       fontSize: 14, fontWeight: FontWeight.w600),
//                     // ),
//                     // SizedBox(
//                     //   height: 10,
//                     // ),
//                     // Container(
//                     //   height: 40,
//                     //   width: MediaQuery.of(context).size.width * 0.3,
//                     //   decoration: BoxDecoration(
//                     //       borderRadius: BorderRadius.circular(25),
//                     //       border: Border.all(
//                     //           color: Colors.grey.shade300, width: 1)),
//                     //   child: DropdownButtonHideUnderline(
//                     //     child: DropdownButton<int>(
//                     //       // Initial Value
//                     //       value: dropdownTotalMilk,
//                     //       // Down Arrow Icon
//                     //       icon: const Icon(Icons.arrow_drop_down_outlined),
//                     //       // Array list of items
//                     //       items: milk.map((int items) {
//                     //         return DropdownMenuItem(
//                     //           value: items,
//                     //           child: Row(
//                     //             mainAxisAlignment:
//                     //                 MainAxisAlignment.spaceEvenly,
//                     //             children: [
//                     //               SizedBox(
//                     //                 width: 10,
//                     //               ),
//                     //               Icon(
//                     //                 MdiIcons.babyBottleOutline,
//                     //                 color: Colors.grey,
//                     //               ),
//                     //               SizedBox(
//                     //                 width: 5,
//                     //               ),
//                     //               Text(
//                     //                 items.toString(),
//                     //                 style: TextStyle(
//                     //                     fontFamily: 'SFProText',
//                     //                     fontWeight: FontWeight.w500,
//                     //                     fontSize: 13,
//                     //                     color: Colors.black),
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         );
//                     //       }).toList(),
//                     //       // After selecting the desired option,it will
//                     //       // change button valuforme to selected value
//                     //       onChanged: (int? newValue) {
//                     //         setState(() {
//                     //           dropdownTotalMilk = newValue!;
//                     //         });
//                     //       },
//                     //     ),
//                     //   ),
//                     // ),
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
//                         key: formkey1,
//                         child: Container(
//                             height: 40,
//                             width: MediaQuery.of(context).size.width * 0.6,
//                             // decoration: BoxDecoration(
//                             //     borderRadius: BorderRadius.circular(25),
//                             //     border: Border.all(
//                             //         color: Colors.grey.shade300, width: 1)),
//                             child: TextFormField(
//                               validator: (value) {
//                                 if (int.parse(value!) > 250 ||
//                                     int.parse(value) == 0 ||
//                                     value.isEmpty) {
//                                   return 'enter valid value';
//                                 }
//                                 return null;
//                               },
//                               controller: milMlController,
//                               keyboardType: TextInputType.number,
//                             ))),
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
//                                   await searchMilkDate();
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
//                 ),
//               );
//             } else
//               return Container(
//                 height: 400,
//                 width: sw,
//                 padding: EdgeInsets.all(10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Datum en tijd',
//                       style: GoogleFonts.inter(
//                           fontSize: 14, fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     DateTimePicker(
//                       type: DateTimePickerType.dateTimeSeparate,
//                       dateMask: 'd MMM, yyyy',
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                       icon: Icon(Icons.event),
//                       dateLabelText: 'Date',
//                       timeLabelText: "Hour",
//                       selectableDayPredicate: (date) {
//                         // Disable weekend days to select from the calendar
//                         return true;
//                       },
//                       onChanged: (val) => uploadDate = DateTime.parse(val),
//                       validator: (val) {
//                         print(val);
//                         return null;
//                       },
//                       onSaved: (val) => print("Saved" + val.toString()),
//                     ),

//                     //                 ElevatedButton(
//                     // style: ButtonStyle(
//                     //   backgroundColor:
//                     //       MaterialStateProperty.all(Colors.amber),
//                     // ),
//                     // onPressed: () {
//                     //   DatePicker.showDateTimePicker(context,
//                     //       showTitleActions: true, onChanged: (date) {
//                     //     print('change $date in time zone ' +
//                     //         date.timeZoneOffset.inHours.toString());
//                     //   }, onConfirm: (date) {
//                     //     print('confirm $date');
//                     //   },
//                     //       currentTime: DateTime(2008, 12, 31, 23, 12, 34),
//                     //       locale: LocaleType.nl);
//                     // },
//                     // child: Text('Datum en tijd')),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Flessen',
//                       style: GoogleFonts.inter(
//                           fontSize: 14, fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       height: 40,
//                       width: MediaQuery.of(context).size.width * 0.3,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           border: Border.all(
//                               color: Colors.grey.shade300, width: 1)),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<int>(
//                           // Initial Value
//                           value: dropdownTempMilk,
//                           // Down Arrow Icon
//                           icon: const Icon(Icons.arrow_drop_down_outlined),
//                           // Array list of items
//                           items: milk.map((int items) {
//                             return DropdownMenuItem(
//                               value: items,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Icon(
//                                     MdiIcons.babyBottleOutline,
//                                     color: Colors.grey,
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     items.toString(),
//                                     style: TextStyle(
//                                         fontFamily: 'SFProText',
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 13,
//                                         color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                           // After selecting the desired option,it will
//                           // change button value to selected value
//                           onChanged: (int? newValue) {
//                             setState(() {
//                               dropdownTempMilk = newValue!;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
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
//                                   await searchMilkDate();
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
//                 ),
//               );
//           } else {
//             return Center(
//                 child: CircularProgressIndicator(
//               color: Theme.of(context).primaryColor,
//             ));
//           }
//         });
//   }

//   searchMilkDate() async {
//     String formattedDate = DateFormat('ddMMyyyy').format(uploadDate);

//     var milkDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(currentUser!.uid)
//         .collection('milk')
//         .doc(formattedDate)
//         .get();

//     if (uploadDate != null) {
//       if (milkDoc.exists) {
//         int milkConsumed =
//             (dropdownTempMilk + int.parse(milkDoc['milkConsumed'].toString()));
//         if (int.parse(milkDoc['maxMilk'].toString()) < milkConsumed) {
//           Navigator.pop(context);

//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             backgroundColor: Theme.of(context).primaryColor,
//             content: Text(
//               "Max Milk Limit Reached",
//               style: TextStyle(color: Colors.black),
//             ),
//           ));
//         } else {
//           var milkDocEdit = await FirebaseFirestore.instance
//               .collection('users')
//               .doc(currentUser!.uid)
//               .collection('milk')
//               .doc(formattedDate);

//           var totalMilk = milkDoc['totalMilk'];
//           totalMilk.add({"litres": dropdownTempMilk, "time": uploadDate});

//           await milkDocEdit
//               .update({"milkConsumed": milkConsumed, "totalMilk": totalMilk});

//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             backgroundColor: Theme.of(context).primaryColor,
//             content: Text(
//               "Milk Added Successfully",
//               style: TextStyle(color: Colors.black),
//             ),
//           ));

//           Navigator.pop(context);
//         }
//       } else {
//         if (dropdownTempMilk > dropdownTotalMilk) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             backgroundColor: Theme.of(context).primaryColor,
//             content: Text(
//               "Max Milk Limit Reached",
//               style: TextStyle(color: Colors.black),
//             ),
//           ));

//           Navigator.pop(context);
//         } else {
//           var milkDocEdit = await FirebaseFirestore.instance
//               .collection('users')
//               .doc(currentUser!.uid)
//               .collection('milk');
//           milkDocEdit.doc(formattedDate).set({
//             "maxMilk": dropdownTotalMilk,
//             "milkConsumed": dropdownTempMilk,
//             "totalMilk": [
//               {"litres": dropdownTempMilk, "time": uploadDate}
//             ],
//             "uploadDate": uploadDate,
//             "uploadDateDayMonth": int.parse(formattedDate)
//           });
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             backgroundColor: Theme.of(context).primaryColor,
//             content: Text(
//               "Milk Added Successfully",
//               style: TextStyle(color: Colors.black),
//             ),
//           ));

//           Navigator.pop(context);
//         }

//         // Navigator.pop(context);

//       }
//     }
//   }
// }

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

import '../widgets/text_fields.dart';

class Home_view extends StatefulWidget {
  const Home_view({Key, key}) : super(key: key);

  @override
  _Home_viewState createState() => _Home_viewState();
}

class _Home_viewState extends State<Home_view> {
  final formkey1 = GlobalKey<FormState>();
  TextEditingController milMlController = TextEditingController();
  var totalMilk = 0;
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  final translator = GoogleTranslator();
  int formattedDate = int.parse(DateFormat('ddMMyyyy').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    print(formattedDate);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        floatingActionButton: InkWell(
          onTap: () {
            milkBottomSheet();
            // showModalBottomSheet(
            //     isScrollControlled: true,
            //     context: context,
            //     builder: (context) {
            //       return Padding(
            //         padding: EdgeInsets.only(
            //             bottom: MediaQuery.of(context).viewInsets.bottom),
            //         child: addMilk_Dialog(
            //           totalMilk: totalMilk,
            //         ),
            //       );
            //     });
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
        body: FutureBuilder<dynamic>(
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
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                snapshot.data['name'],
                                style: GoogleFonts.dmSans(
                                    fontSize: 48, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '$weeks weeks $days days',
                                style: GoogleFonts.dmSans(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: sh * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/home.png'),
                                    fit: BoxFit.fill)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx((() => MilkWdget())),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUser!.uid)
                            .collection('milk')
                            .where('uploadDateDayMonth',
                                isGreaterThanOrEqualTo: formattedDate)
                            .snapshots(),
                        builder: (context, snapshots) {
                          if (snapshots.hasData) {
                            return Expanded(
                              child: ListView(
                                children: snapshots.data!.docs.map((document) {
                                  return FutureBuilder(
                                      future: getDay(
                                          document['uploadDate'].toDate()),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children: [
                                              Container(
                                                width: sw * 0.92,
                                                padding: EdgeInsets.all(10),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: Color(0xfffffbe0),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data.toString(),
                                                      style: GoogleFonts.dmSans(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Container(
                                                      height: 20,
                                                      width: 100,
                                                      child:
                                                          LinearPercentIndicator(
                                                        width: 100.0,
                                                        lineHeight: 20.0,
                                                        barRadius:
                                                            Radius.circular(20),
                                                        percent: (document[
                                                                'milkConsumed'] /
                                                            document[
                                                                'maxMilk']),
                                                        progressColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(MdiIcons
                                                            .babyBottleOutline),
                                                        Text(
                                                          " ${document['milkConsumed']}/${document['maxMilk']} Flessen",
                                                          style: GoogleFonts
                                                              .dmSans(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
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
                                                height: 140,
                                                width: sw * 0.9,
                                                color: Colors.transparent,
                                                child: ListView.separated(
                                                  separatorBuilder:
                                                      ((context, index) {
                                                    return SizedBox(
                                                      height: 20,
                                                    );
                                                  }),
                                                  itemCount:
                                                      document['totalMilk']
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DateFormat dateFormat =
                                                        DateFormat("hh:mm a");
                                                    String milkTime = dateFormat
                                                        .format(document[
                                                                    'totalMilk']
                                                                [index]['time']
                                                            .toDate());

                                                    return Container(
                                                      width: sw * 0.9,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfffffbe0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(MdiIcons
                                                                  .clockOutline),
                                                              Text(
                                                                " " + milkTime,
                                                                style: GoogleFonts.dmSans(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(MdiIcons
                                                                  .babyBottleOutline),
                                                              Text(
                                                                (' ' +
                                                                    document['totalMilk'][index]
                                                                            [
                                                                            'litres']
                                                                        .toString() +
                                                                    ' Flessen'),
                                                                style: GoogleFonts.dmSans(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Icon(Icons
                                                                  .arrow_forward_ios),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          );
                                        } else
                                          return Center(
                                              child: CircularProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ));
                                      });
                                }).toList(),
                              ),
                            );
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ));
                          }
                        })
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                );
              }
            }));
  }

  getData() async {
    var temp = await collectionReference.doc(currentUser!.uid).get();
    return temp;
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
              // Container(
              //   height: 20,
              //   width: 100,
              //   child: LinearPercentIndicator(
              //     width: 100.0,
              //     lineHeight: 20.0,
              //     barRadius: Radius.circular(20),
              //     percent: (1.0),
              //     progressColor: Theme.of(context).primaryColor,
              //     backgroundColor: Colors.white,
              //   ),
              // ),
              // Row(
              //   children: [
              //     Icon(MdiIcons.babyBottleOutline),
              //     Text(
              //       " Flessen",
              //       style: GoogleFonts.dmSans(
              //           fontSize: 18, fontWeight: FontWeight.w500),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: Get.height / 3,
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
              // totalMilk = totalMilk +
              //     int.parse(
              //         Get.find<HomeController>().milkData[index]['milkVal']);
              // totalMilk.add(int.parse(
              //     Get.find<HomeController>().milkData[index]['milkVal']));
              // print(totalMilk);
              // totalMilk = int.parse(
              //     Get.find<HomeController>().milkData[index]['milkVal']);

              totalMilk = totalMilk +
                  int.parse(
                      Get.find<HomeController>().milkData[index]['milkVal']);
              print(totalMilk);
              // DateFormat dateFormat = DateFormat("hh:mm a");
              // String milkTime = "23:78";
              DateFormat dateFormat = DateFormat("hh:mm a");
              String milkTime = dateFormat.format(Get.find<HomeController>()
                  .milkData[index]['dateTime']
                  .toDate());
              return Container(
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
                    Row(
                      children: [
                        Icon(MdiIcons.babyBottleOutline),
                        Text(
                          (' ' +
                                  Get.find<HomeController>().milkData[index]
                                      ['milkVal']) +
                              "mL",
                          style: GoogleFonts.dmSans(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),

                        // Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ],
                ),
              );
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
                    // Text(
                    //   'Datum en tijd',
                    //   style: GoogleFonts.inter(
                    //       fontSize: 14, fontWeight: FontWeight.w600),
                    // ),
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
                            print('confirm $date');
                          },
                              currentTime: DateTime(2008, 12, 31, 23, 12, 34),
                              locale: LocaleType.nl);
                        },
                        child: Text('Datum en tijd')),

                    // DateTimePicker(
                    //   type: DateTimePickerType.dateTimeSeparate,
                    //   dateMask: 'd MMM, yyyy',
                    //   firstDate: DateTime(2000),
                    //   lastDate: DateTime(2100),
                    //   icon: Icon(Icons.event),
                    //   dateLabelText: 'Date',
                    //   timeLabelText: "Hour",
                    //   selectableDayPredicate: (date) {
                    //     // Disable weekend days to select from the calendar
                    //     return true;
                    //   },
                    //   onChanged: (val) => uploadDate = DateTime.parse(val),
                    //   validator: (val) {
                    //     print(val);
                    //     return null;
                    //   },
                    //   onSaved: (val) => print("Saved" + val.toString()),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'Flessen',
                    //   style: GoogleFonts.inter(
                    //       fontSize: 14, fontWeight: FontWeight.w600),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   height: 40,
                    //   width: MediaQuery.of(context).size.width * 0.3,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(25),
                    //       border: Border.all(
                    //           color: Colors.grey.shade300, width: 1)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<int>(
                    //       // Initial Value
                    //       value: dropdownTempMilk,
                    //       // Down Arrow Icon
                    //       icon: const Icon(Icons.arrow_drop_down_outlined),
                    //       // Array list of items
                    //       items: milk.map((int items) {
                    //         return DropdownMenuItem(
                    //           value: items,
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               SizedBox(
                    //                 width: 10,
                    //               ),
                    //               Icon(
                    //                 MdiIcons.babyBottleOutline,
                    //                 color: Colors.grey,
                    //               ),
                    //               SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 items.toString(),
                    //                 style: TextStyle(
                    //                     fontFamily: 'SFProText',
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: 13,
                    //                     color: Colors.black),
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       }).toList(),
                    //       // After selecting the desired option,it will
                    //       // change button value to selected value
                    //       onChanged: (int? newValue) {
                    //         setState(() {
                    //           dropdownTempMilk = newValue!;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
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
                          )

                          //  DropdownButtonHideUnderline(
                          //   child: DropdownButton<int>(
                          //     // Initial Value
                          //     value: dropdownTotalMilk,
                          //     // Down Arrow Icon
                          //     icon: const Icon(Icons.arrow_drop_down_outlined),
                          //     // Array list of items
                          //     items: milk.map((int items) {
                          //       return DropdownMenuItem(
                          //         value: items,
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             SizedBox(
                          //               width: 10,
                          //             ),
                          //             Icon(
                          //               MdiIcons.babyBottleOutline,
                          //               color: Colors.grey,
                          //             ),
                          //             SizedBox(
                          //               width: 5,
                          //             ),
                          //             Text(
                          //               items.toString(),
                          //               style: TextStyle(
                          //                   fontFamily: 'SFProText',
                          //                   fontWeight: FontWeight.w500,
                          //                   fontSize: 13,
                          //                   color: Colors.black),
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     }).toList(),
                          //     // After selecting the desired option,it will
                          //     // change button value to selected value
                          //     onChanged: (int? newValue) {
                          //       setState(() {
                          //         dropdownTotalMilk = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),
                          ),
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
                                  if (formkey1.currentState!.validate()) {
                                    // await searchMilkDate();
                                    print(totalMilk +
                                        int.parse(milMlController.text));
                                    if (totalMilk +
                                            int.parse(milMlController.text) >=
                                        250) {
                                      CommonWidgets.toastShow("Limit exceed");
                                    } else {
                                      FirestoreMethods.updateMilkValue({
                                        "milkVal": milMlController.text,
                                        "dateTime": Timestamp.now(),
                                      });
                                    }

                                    // FirestoreMethods.updateMilk({
                                    //   "milkVal": milMlController.text,
                                    //   "dateTime": Timestamp.now(),
                                    // });
                                  }
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
}

class addMilk_Dialog extends StatefulWidget {
  const addMilk_Dialog({Key, key, required this.totalMilk}) : super(key: key);
  final int totalMilk;
  @override
  _addMilk_DialogState createState() => _addMilk_DialogState();
}

class _addMilk_DialogState extends State<addMilk_Dialog> {
  final formkey1 = GlobalKey<FormState>();
  TextEditingController milMlController = TextEditingController();
  var uploadDate;
  // TextEditingController _milkController = new TextEditingController();
  // TextEditingController _totalMilkController = new TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;
  int dropdownTotalMilk = 1;
  int dropdownTempMilk = 1;
  int formattedDate =
      int.parse(DateFormat('dMMyyyy').format(DateTime.now()).toString());

  // List of items in our dropdown menu
  var milk = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    print(formattedDate);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .collection('milk')
            .where('uploadDateDayMonth', isEqualTo: formattedDate)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("hereeeeeeeeeeeeeee");
            print(snapshot.data!.docs.length.toString());
            if (snapshot.data!.docs.length == 0) {
              return Container(
                height: Get.height / 2.4,
                width: sw,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Datum en tijd',
                    //   style: GoogleFonts.inter(
                    //       fontSize: 14, fontWeight: FontWeight.w600),
                    // ),
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
                            print('confirm $date');
                          },
                              currentTime: DateTime(2008, 12, 31, 23, 12, 34),
                              locale: LocaleType.nl);
                        },
                        child: Text('Datum en tijd')),

                    // DateTimePicker(
                    //   type: DateTimePickerType.dateTimeSeparate,
                    //   dateMask: 'd MMM, yyyy',
                    //   firstDate: DateTime(2000),
                    //   lastDate: DateTime(2100),
                    //   icon: Icon(Icons.event),
                    //   dateLabelText: 'Date',
                    //   timeLabelText: "Hour",
                    //   selectableDayPredicate: (date) {
                    //     // Disable weekend days to select from the calendar
                    //     return true;
                    //   },
                    //   onChanged: (val) => uploadDate = DateTime.parse(val),
                    //   validator: (val) {
                    //     print(val);
                    //     return null;
                    //   },
                    //   onSaved: (val) => print("Saved" + val.toString()),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'Flessen',
                    //   style: GoogleFonts.inter(
                    //       fontSize: 14, fontWeight: FontWeight.w600),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   height: 40,
                    //   width: MediaQuery.of(context).size.width * 0.3,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(25),
                    //       border: Border.all(
                    //           color: Colors.grey.shade300, width: 1)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<int>(
                    //       // Initial Value
                    //       value: dropdownTempMilk,
                    //       // Down Arrow Icon
                    //       icon: const Icon(Icons.arrow_drop_down_outlined),
                    //       // Array list of items
                    //       items: milk.map((int items) {
                    //         return DropdownMenuItem(
                    //           value: items,
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               SizedBox(
                    //                 width: 10,
                    //               ),
                    //               Icon(
                    //                 MdiIcons.babyBottleOutline,
                    //                 color: Colors.grey,
                    //               ),
                    //               SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 items.toString(),
                    //                 style: TextStyle(
                    //                     fontFamily: 'SFProText',
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: 13,
                    //                     color: Colors.black),
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       }).toList(),
                    //       // After selecting the desired option,it will
                    //       // change button value to selected value
                    //       onChanged: (int? newValue) {
                    //         setState(() {
                    //           dropdownTempMilk = newValue!;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
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
                          )

                          //  DropdownButtonHideUnderline(
                          //   child: DropdownButton<int>(
                          //     // Initial Value
                          //     value: dropdownTotalMilk,
                          //     // Down Arrow Icon
                          //     icon: const Icon(Icons.arrow_drop_down_outlined),
                          //     // Array list of items
                          //     items: milk.map((int items) {
                          //       return DropdownMenuItem(
                          //         value: items,
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             SizedBox(
                          //               width: 10,
                          //             ),
                          //             Icon(
                          //               MdiIcons.babyBottleOutline,
                          //               color: Colors.grey,
                          //             ),
                          //             SizedBox(
                          //               width: 5,
                          //             ),
                          //             Text(
                          //               items.toString(),
                          //               style: TextStyle(
                          //                   fontFamily: 'SFProText',
                          //                   fontWeight: FontWeight.w500,
                          //                   fontSize: 13,
                          //                   color: Colors.black),
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     }).toList(),
                          //     // After selecting the desired option,it will
                          //     // change button value to selected value
                          //     onChanged: (int? newValue) {
                          //       setState(() {
                          //         dropdownTotalMilk = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),
                          ),
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
                                  if (formkey1.currentState!.validate()) {
                                    // await searchMilkDate();
                                    print(this.widget.totalMilk +
                                        int.parse(milMlController.text));
                                    if (this.widget.totalMilk +
                                            int.parse(milMlController.text) >=
                                        250) {
                                      CommonWidgets.toastShow("Limit exceed");
                                    } else {
                                      FirestoreMethods.updateMilkValue({
                                        "milkVal": milMlController.text,
                                        "dateTime": Timestamp.now(),
                                      });
                                    }
                                    Get.back();
                                    // FirestoreMethods.updateMilk({
                                    //   "milkVal": milMlController.text,
                                    //   "dateTime": Timestamp.now(),
                                    // });
                                  }
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
                ),
              );
            } else
              return Container(
                height: 400,
                width: sw,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Datum en tijd',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DateTimePicker(
                      type: DateTimePickerType.dateTimeSeparate,
                      dateMask: 'd MMM, yyyy',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      timeLabelText: "Hour",
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        return true;
                      },
                      onChanged: (val) => uploadDate = DateTime.parse(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print("Saved" + val.toString()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Flessen',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          // Initial Value
                          value: dropdownTempMilk,
                          // Down Arrow Icon
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          // Array list of items
                          items: milk.map((int items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    MdiIcons.babyBottleOutline,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    items.toString(),
                                    style: TextStyle(
                                        fontFamily: 'SFProText',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (int? newValue) {
                            setState(() {
                              dropdownTempMilk = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                                  await searchMilkDate();
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
                ),
              );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }
        });
  }

  searchMilkDate() async {
    String formattedDate = DateFormat('ddMMyyyy').format(uploadDate);

    var milkDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('milk')
        .doc(formattedDate)
        .get();

    if (uploadDate != null) {
      if (milkDoc.exists) {
        int milkConsumed = int.parse(milMlController.text);
        // (dropdownTempMilk + int.parse(milkDoc['milkConsumed'].toString()));
        if (int.parse(milkDoc['maxMilk'].toString()) < milkConsumed) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(
              "Max Milk Limit Reached",
              style: TextStyle(color: Colors.black),
            ),
          ));
        } else {
          var milkDocEdit = await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser!.uid)
              .collection('milk')
              .doc(formattedDate);

          var totalMilk = milkDoc['totalMilk'];
          totalMilk.add({"litres": dropdownTempMilk, "time": uploadDate});

          await milkDocEdit
              .update({"milkConsumed": milkConsumed, "totalMilk": totalMilk});

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(
              "Milk Added Successfully",
              style: TextStyle(color: Colors.black),
            ),
          ));

          Navigator.pop(context);
        }
      } else {
        if (dropdownTempMilk > dropdownTotalMilk) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(
              "Max Milk Limit Reached",
              style: TextStyle(color: Colors.black),
            ),
          ));

          Navigator.pop(context);
        } else {
          var milkDocEdit = await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser!.uid)
              .collection('milk');
          milkDocEdit.doc(formattedDate).set({
            "maxMilk": dropdownTotalMilk,
            "milkConsumed": dropdownTempMilk,
            "totalMilk": [
              {"litres": dropdownTempMilk, "time": uploadDate}
            ],
            "uploadDate": uploadDate,
            "uploadDateDayMonth": int.parse(formattedDate)
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(
              "Milk Added Successfully",
              style: TextStyle(color: Colors.black),
            ),
          ));

          Navigator.pop(context);
        }

        // Navigator.pop(context);

      }
    }
  }
}
