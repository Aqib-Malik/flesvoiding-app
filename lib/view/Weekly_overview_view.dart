import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flesvoieding/constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:translator/translator.dart';
import 'package:date_time_picker/date_time_picker.dart';

import '../controller/home_controller.dart';
import 'Home_view.dart';

class weeklyOverview_view extends StatefulWidget {
  const weeklyOverview_view({Key, key}) : super(key: key);

  @override
  _weeklyOverview_viewState createState() => _weeklyOverview_viewState();
}

class _weeklyOverview_viewState extends State<weeklyOverview_view> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  final translator = GoogleTranslator();
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Ma', y: 0, color: Colors.red),
    ChartSampleData(x: 'Di', y: 0, color: Colors.lightBlueAccent),
    ChartSampleData(x: 'Wo', y: 0, color: Colors.blue.shade800),
    ChartSampleData(x: 'Do', y: 0, color: Colors.lightGreen),
    ChartSampleData(x: 'Vr', y: 0, color: Colors.pink),
    ChartSampleData(x: 'Za', y: 0, color: Colors.red.shade800),
    ChartSampleData(x: 'Zo', y: 0, color: Colors.purple),
  ];
  @override
  void initState() {
    print(Get.find<HomeController>().milkData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     showDialog(
      //         context: context,
      //         builder: (context) {
      //           return addMilk_Dialog(
      //             totalMilk: 0,
      //           );
      //         });
      //   },
      //   child: Container(
      //     padding: EdgeInsets.all(10),
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: Theme.of(context).primaryColor,
      //     ),
      //     child: Icon(
      //       Icons.add,
      //       color: Colors.white,
      //       size: 30,
      //     ),
      //   ),
      // ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('milk')
              .get()
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data!.docs.forEach((element) {
                print(element['uploadDate']);
                Timestamp timestamp = element['uploadDate'];
                print(timestamp.toDate());
                print(timestamp.toDate().weekday);
                if (timestamp.toDate().weekOfMonth ==
                        DateTime.now().weekOfMonth &&
                    timestamp.toDate().month == DateTime.now().month &&
                    timestamp.toDate().year == DateTime.now().year) {
                  if (timestamp.toDate().weekday == 1) {
                    chartData[0] = ChartSampleData(
                        x: 'Ma',
                        y: double.parse(element['milkConsumed'].toString()),
                        color: Colors.red);
                  } else if (timestamp.toDate().weekday == 2) {
                    chartData[1] = ChartSampleData(
                        x: 'Di',
                        y: double.parse(element['milkConsumed'].toString()),
                        color: Colors.blue);
                  } else if (timestamp.toDate().weekday == 3) {
                    chartData[2] = ChartSampleData(
                        x: 'Wo',
                        y: double.parse(element['milkConsumed'].toString()),
                        color: Colors.green);
                  } else if (timestamp.toDate().weekday == 4) {
                    chartData[3] = ChartSampleData(
                        x: 'Do',
                        y: double.parse(element['milkConsumed'].toString()),
                        color: Colors.yellow.shade800);
                  } else if (timestamp.toDate().weekday == 5) {
                    chartData[4] = ChartSampleData(
                        x: 'Vr',
                        y: double.parse(element['milkConsumed'].toString()),
                        color: Colors.pink);
                  } else if (timestamp.toDate().weekday == 6) {
                    chartData[5] = ChartSampleData(
                        x: 'Za',
                        y: double.parse(element['milkConsumed'].toString()),
                        color: Colors.orange);
                  } else if (timestamp.toDate().weekday == 7) {
                    chartData[6] = ChartSampleData(
                        x: 'Zo',
                        y: double.parse(element['milkConsumed'].toString()),
                        color: Colors.purple);
                  }
                }
              });
              return SingleChildScrollView(
                child: FutureBuilder<dynamic>(
                    future: getData(),
                    builder: (context, userData) {
                      if (userData.hasData) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        '${userData.data['name']}',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 48,
                                            fontWeight: FontWeight.w700),
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
                              height: sh * 0.1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Weekoverzicht',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Container(
                            //       width: MediaQuery.of(context).size.width * 0.5,
                            //       child: DropdownButtonFormField<String>(
                            //         items: _getList().map((String value) {
                            //           return DropdownMenuItem<String>(
                            //             value: value,
                            //             child: Text(
                            //               value,
                            //               style: GoogleFonts.inter(
                            //                 color: Colors.black,
                            //               ),
                            //             ),
                            //           );
                            //         }).toList(),
                            //         onChanged: (value) {},
                            //         decoration: InputDecoration(
                            //           contentPadding: EdgeInsets.all(10),
                            //           border: OutlineInputBorder(
                            //               borderSide: BorderSide.none),
                            //           focusedBorder: OutlineInputBorder(
                            //               borderSide: BorderSide.none),
                            //           disabledBorder: OutlineInputBorder(
                            //               borderSide: BorderSide.none),
                            //           enabledBorder: OutlineInputBorder(
                            //               borderSide: BorderSide.none),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelStyle: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                series: <ColumnSeries<ChartSampleData, String>>[
                                  ColumnSeries<ChartSampleData, String>(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    pointColorMapper:
                                        (ChartSampleData sales, _) =>
                                            sales.color,
                                    width: -0.5,
                                    // Binding the chartData to the dataSource of the column series.
                                    dataSource: chartData,
                                    xValueMapper: (ChartSampleData sales, _) =>
                                        sales.x,
                                    yValueMapper: (ChartSampleData sales, _) =>
                                        sales.y,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        );
                      } else
                        return Center(
                            child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ));
                    }),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }
          }),
    );
  }

  getData() async {
    var temp = await collectionReference.doc(currentUser!.uid).get();
    return temp;
  }

  List<String> _getList() {
    int _currentDateMonth = DateTime.now().month;

    return [];
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.y, this.color});
  var color;
  final String? x;
  final double? y;
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}
