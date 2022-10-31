import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flesvoieding/constant/Constants.dart';
import 'package:flesvoieding/view/Bottom_Nav_Bar.dart';
import 'package:flesvoieding/view/Home_view.dart';
import 'package:flesvoieding/view/Signup_view.dart';
import 'package:flesvoieding/widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Terms extends StatefulWidget {
  const Terms({Key, key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {

  CollectionReference collectionReference = FirebaseFirestore.instance.collection('terms');
  
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
        title: Text(
          'Algemene voorwaarden',
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:StreamBuilder<QuerySnapshot>(
                  stream:FirebaseFirestore.instance.collection('terms').get().asStream(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. Terms',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '${snapshot.data!.docs.first['term']}',
                          style: GoogleFonts.inter(
                              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
                        maxLines: 600,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '2. Conditions',
                          style: GoogleFonts.inter(
                              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '${snapshot.data!.docs.first['condition']}',
                          style: GoogleFonts.inter(
                              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
                          maxLines: 600,
                        ),
                        SizedBox(height: 20,),
                      ],
                    );
                  }else
    return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
    }

                )
              ),
      ),
    );
  }

  getData() async{
    var temp = await collectionReference.doc('4LHdslPpT86lcvnVn9OU').get();

    return temp;

    // _emailController.text = currentUser!.email.toString();
    // _nameController.text = temp['name'];
    // var difference = calculateAge(temp['birthDate'].toDate());
    // birthDate = temp['birthDate'].toDate();

    // var weeks = ( difference / 7 ).round();
    // var days = difference % 7;
    // _ageController.text = weeks.toString() + " Weeks " + days.toString() + " Days";

    // return UserProfileModel(
    //   email: currentUser!.email,
    //   name: temp['name'],
    //   weight: temp['weight'],
    //   birthDate: temp['birthDate'].toDate()
    // );
  }


}
