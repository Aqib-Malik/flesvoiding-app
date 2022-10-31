import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flesvoieding/view/Terms&Conditions.dart';
import 'package:flesvoieding/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class Signup_view extends StatefulWidget {
  const Signup_view({Key, key}) : super(key: key);

  @override
  _Signup_viewState createState() => _Signup_viewState();
}

class _Signup_viewState extends State<Signup_view> {
  String imageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIPSl4UX-A38hPN8s4lQZyz9nycz5mPUxMsYGXLRYQ&s";

  var obscure = true;
  var check = true;
  var ageWeeks = 0;
  var ageDays = 0;
  DateTime birthDate = DateTime.now();
  bool _loading = false;

  File? _imageFile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'Sign Up',
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
              Row(
                children: [
                  Text(
                    'Create Account ',
                    style: GoogleFonts.inter(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    MdiIcons.handWave,
                    color: Colors.yellow.shade800,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: getImage,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: (_imageFile != null)
                        ? Image.file(
                            File(_imageFile!.path.toString()),
                            fit: BoxFit.cover,
                          ).image
                        : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Naam baby ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormFieldWithPrefix(
                keyboardType: TextInputType.name,
                controller: _nameController,
                readOnly: false,
                hintText: 'Vul de baby’s naam in',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'E-mailadres ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormFieldWithPrefix(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                readOnly: false,
                hintText: 'Vul je e-mailadres in',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Geboortedatum baby ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: CustomTextFormFieldWithPrefix(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  readOnly: true,
                  onTap: () async {
                    birthDate = await selectDate(context, DateTime.now(),
                        lastDate: DateTime.now());
                    final df = DateFormat('dd-MMM-yyyy');
                    var age = calculateAge(birthDate);
                    var weeks = (age / 7).toInt();
                    var days = age % 7;

                    this.ageWeeks = weeks;
                    this.ageDays = days;

                    _ageController.text = "$weeks Week $days Days";
                    setState(() {});
                  },
                  hintText: 'Vul de geboortedatum van de baby in',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Gewicht van de baby ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                'Wachtwoord ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomPasswordFormFieldWithPrefix(
                controller: _passwordController,
                hintText: 'Vul in welk wachtwoord je wilt gebruiken',
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Bevestigen wachtwoord ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomPasswordFormFieldWithPrefix(
                hintText: 'Vul je wachtwoord in',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          // if (_imageFile != null) {
                          //   uploadImage(_imageFile, _emailController.text)
                          //       .then((value) {
                          //     imageUrl = value;
                          //     signUp(ageWeeks, ageDays);
                          //   });
                          // }
                          signUp(ageWeeks, ageDays);
                        },
                        child: _loading
                            ? const SizedBox(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 1.5,
                                ),
                                height: 15.0,
                                width: 15.0,
                              )
                            : Text(
                                'Registreer',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Door je te registreren ga je akkoord met onze ',
                    style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Terms()));
                    },
                    child: Text(
                      ' Algemene voorwaarden ',
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path.toString());
      });
    }
  }

  Future signUp(ageWeeks, ageDays) async {
    try {
      _loading = true;
      setState(() {});
      var user;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .whenComplete(() => {
                user = FirebaseAuth.instance.currentUser?.uid,
                FirebaseAuth.instance.signOut(),
              });

      if (_imageFile != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        var date = DateTime.now().toString();

        String fileName = _imageFile!.path.split('/').last;
        var currentUser = FirebaseAuth.instance.currentUser;

        Reference ref = storage.ref('profile_images').child(currentUser!.uid);

        await ref.putFile(File(_imageFile!.path));
        imageUrl = await ref.getDownloadURL();
        print(imageUrl);
      }

      final docUser = FirebaseFirestore.instance.collection("users");

      final json1 = {
        "email": _emailController.text.trim(),
        "name": _nameController.text,
        "birthDate": birthDate,
        "imageUrl": imageUrl,
        "today_milk": null,
      };

      await docUser.doc(user).set(json1);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: const Text(
          "Signed Up Successfully",
          style: TextStyle(color: Colors.black),
        ),
      ));

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
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
        setState(() {});
      });
    else
      DatePicker.showDatePicker(
        context,
        dateFormat: 'yyyy-mmm-dd',
        locale: DateTimePickerLocale.en_us,
        onConfirm: (temp, selectedIndex) {
          if (temp == null) return null;
          completer.complete(temp);

          setState(() {});
        },
      );
    return completer.future;
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    final date2 = DateTime.now();
    final difference = date2.difference(birthDate).inDays;
    return difference;
  }

  ///****upload account pic on firebase Storage******/
  static Future<String> uploadImage(_image, email) async {
    var imagestatus = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child(email + ".jpg")
        .putFile(_image) //await StorageFirebaseServices.getImage())
        .then((value) => value);
    String imageUrl = await imagestatus.ref.getDownloadURL();
    return imageUrl;
  }
}
