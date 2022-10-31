import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flesvoieding/constant/Constants.dart';
import 'package:flesvoieding/view/Profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:url_launcher/url_launcher.dart';
class Blogs_view extends StatefulWidget {
  const Blogs_view({Key, key}) : super(key: key);

  @override
  _Blogs_viewState createState() => _Blogs_viewState();
}

class _Blogs_viewState extends State<Blogs_view> {
  var status=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Blogs',
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('blogs').orderBy('uploadTime', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                } 
                else {
                  return Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: sw,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:NetworkImage(document['imagePath']))
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(document['title'],style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 15,color: Colors.black),),
                              SizedBox(height: 10,),
                              Text(document['description'],textAlign:TextAlign.left,style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),maxLines: 5,overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 10,),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      padding: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5))),
                                  onPressed: () {
                                    document['link'] != "test" ? 
                                      launchUrl(
                                        Uri.parse(
                                            document['link']),
                                        mode: LaunchMode
                                            .externalApplication) : null;
                                  },
                                  child: Text(
                                    'Lees verder',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        );
                    }).toList()),
                  );
                }
              }),
          ],
        ),
      ),
    );
  }
}
