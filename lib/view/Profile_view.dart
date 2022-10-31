import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flesvoieding/constant/Constants.dart';
import 'package:flesvoieding/model/userProfileModel.dart';
import 'package:flesvoieding/widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/src/intl/date_format.dart';

class Profile_view extends StatefulWidget {
  const Profile_view({Key, key}) : super(key: key);

  @override
  _Profile_viewState createState() => _Profile_viewState();
}

class _Profile_viewState extends State<Profile_view> {
  File? _image;
  var status = true;
  bool _loading = false;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  var birthDate = DateTime.now();

  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  String _imageUrl = "";

  @override
  Widget build(BuildContext context) {
    print("heree");
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
          'Mijn profiel',
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: FutureBuilder<dynamic>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: [
                          Center(
                            child: _image != null
                                ? CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: FileImage(_image!))
                                : CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: (_imageUrl == "")
                                        ? NetworkImage(
                                            'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg')
                                        : NetworkImage(_imageUrl)),
                          ),
                          Positioned(
                            top: 60,
                            left: 180,
                            child: Center(
                              child: GestureDetector(
                                  onTap: () async {
                                    await getImage();
                                    // setState(() {
                                    //   _image = _image;
                                    // });
                                    // _image =
                                    //     await context.read<AccountProvider>().getImage();
                                    // print("setstate");

                                    // _image =
                                    //     await StorageFirebaseServices.getImage();
                                    // Provider.of<AccountProvider>(context,
                                    //         listen: false)
                                    //     .acSetImg = _image;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Naam baby',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      CustomProfileTextFormFieldWithPrefix(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          readOnly: false),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'E-mailadres',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      CustomProfileTextFormFieldWithPrefix(
                          controller: _emailController,
                          keyboardType: TextInputType.name,
                          readOnly: true),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Leeftij van de baby',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      GestureDetector(
                        child: CustomProfileTextFormFieldWithPrefix(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          readOnly: true,
                          onTap: () async {
                            birthDate = await selectDate(
                                context, DateTime.now(),
                                lastDate: DateTime.now());
                            var age = calculateAge(birthDate);
                            print(age);
                            var weeks = (age / 7).toInt();
                            var days = age % 7;
                            _ageController.text = "$weeks Week $days Days";
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: _loading
                                  ? SizedBox(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 1.5,
                                      ),
                                      height: 15.0,
                                      width: 15.0,
                                    )
                                  : Text('Pas profiel aan'),
                              onPressed: editProfile,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                primary: Theme.of(context).primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                textStyle: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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

  selectDate(BuildContext context, DateTime initialDateTime,
      {required DateTime lastDate}) async {
    Completer completer = Completer();
    String _selectedDateInString;
    if (Platform.isAndroid)
      showDatePicker(
              context: context,
              initialDate: initialDateTime,
              firstDate: DateTime(1970),
              lastDate: lastDate == null
                  ? DateTime(initialDateTime.year + 10)
                  : lastDate)
          .then((temp) {
        if (temp == null) return null;
        completer.complete(temp);
        // setState(() {});
      });
    else
      DatePicker.showDatePicker(
        context,
        dateFormat: 'yyyy-mmm-dd',
        locale: DateTimePickerLocale.en_us,
        onConfirm: (temp, selectedIndex) {
          if (temp == null) return null;
          completer.complete(temp);

          // setState(() {});
        },
      );
    return completer.future;
  }

  getData() async {
    var temp = await collectionReference.doc(currentUser!.uid).get();

    _emailController.text = currentUser!.email.toString();
    _nameController.text = temp['name'];
    var difference = calculateAge(temp['birthDate'].toDate());
    birthDate = temp['birthDate'].toDate();

    var weeks = (difference / 7).round();
    var days = difference % 7;
    _ageController.text =
        weeks.toString() + " Weeks " + days.toString() + " Days";

    _imageUrl = temp['imageUrl'];

    return UserProfileModel(
        email: currentUser!.email,
        name: temp['name'],
        birthDate: temp['birthDate'].toDate());
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    final date2 = DateTime.now();
    final difference = date2.difference(birthDate).inDays;
    return difference;
  }

  editProfile() async {
    String imageUrl;
    _loading = true;
    setState(() {});
    if (_image != null) {
      var imagestatus = await FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(currentUser!.uid.toString() + ".jpg")
          .putFile(_image!) //await StorageFirebaseServices.getImage())
          .then((value) => value);
      imageUrl = await imagestatus.ref.getDownloadURL();
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print(imageUrl);
      var temp = await collectionReference.doc(currentUser!.uid);

      await temp.update({
        "name": _nameController.text,
        "birthDate": birthDate,
        "imageUrl": imageUrl
      }).whenComplete(() {
        _loading = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            "Profile Updated Successfully",
            style: TextStyle(color: Colors.black),
          ),
        ));
      });
    } else {
      var temp = await collectionReference.doc(currentUser!.uid);

      await temp.update({
        "name": _nameController.text,
        "birthDate": birthDate,
      }).whenComplete(() {
        _loading = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            "Profile Updated Successfully",
            style: TextStyle(color: Colors.black),
          ),
        ));
      });
    }
  }

  ///****Pick image freom mob Gallery******/
  Future getImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path.toString());
      });
    }
  }
}
