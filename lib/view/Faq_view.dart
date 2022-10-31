import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:url_launcher/url_launcher.dart';

class Faq_view extends StatefulWidget {
  const Faq_view({Key, key}) : super(key: key);

  @override
  _Faq_viewState createState() => _Faq_viewState();
}

class _Faq_viewState extends State<Faq_view> {

  TextEditingController subjectController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();


  var obscure = true;
  var check = true;
  
  bool _loading = false;
  
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
          'Neem contact op',
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Text(
              //       'FAQs ',
              //       style: GoogleFonts.inter(
              //           fontSize: 24, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //
              //   children: [
              //     Text(
              //       'Age of baby? ',
              //       style: GoogleFonts.inter(
              //           fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     IconButton(
              //         onPressed: () {},
              //         icon: Icon(
              //           Icons.arrow_drop_down_circle_rounded,
              //           color: Colors.black,
              //           size: 20,
              //         )),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Weight of baby? ',
              //       style: GoogleFonts.inter(
              //           fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     IconButton(
              //         onPressed: () {},
              //         icon: Icon(
              //           Icons.arrow_drop_down_circle_rounded,
              //           color: Colors.black,
              //           size: 20,
              //         )),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                children: [
                  Text(
                    'Neem contact met ons op ',
                    style: GoogleFonts.inter(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Onderwerp ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormFieldWithPrefix(
                controller: subjectController,
                keyboardType: TextInputType.text,
                readOnly: false,
                hintText: 'Voer onderwerp in',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bericht ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              
               TextFormField(
                  minLines: 8,
                  maxLines: 20,
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
                    ),
                    // prefixIcon: widget.prefixIcon,
                    hintText: 'Voer beschrijving in',
                    hintStyle: GoogleFonts.inter(fontSize:12,color:Colors.grey),
                    // label: widget.label != null ? Text(widget.label!) : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      setState(() {
                      });
                      return "Please fill out this feild";
                    }
                    return null;
                  },
                ),

              // CustomTextFormFieldWithPrefix(
                
              //   keyboardType: TextInputType.text,
              //   readOnly: false,
              //   hintText: 'Voer beschrijving in',
              // ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: submitForm,
                        child: _loading ? SizedBox(
                            child: CircularProgressIndicator(color: Colors.black, strokeWidth: 1.5,),
                            height: 15.0,
                            width: 15.0,
                          ) : Text(
                          'Versturen',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' Volg ons ',
                      style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                                'https://www.instagram.com/flesvoedingtracker/'),
                            mode: LaunchMode
                                .externalApplication);
                        },
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.red.shade800,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                          size: 30,
                        )) ,
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue,
                          size: 30,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  submitForm() async{
    
      _loading = true;


      setState(() {
        
      });

      final docUser = FirebaseFirestore.instance.collection("contact");
      var currentUser = FirebaseAuth.instance.currentUser!.uid;
      
      final json = {
        "id" : currentUser,
        "subject" : subjectController.text,
        "description" : descriptionController.text,
      };
      await docUser.add(json);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
          backgroundColor: Theme.of(context).primaryColor,
          content: Text("Submitted Successfully", style: TextStyle(color: Colors.black),),
      ));

      _loading = false;
      
      subjectController.text = "";
      descriptionController.text = "";

      setState(() {
        
      });

      
  }
}
