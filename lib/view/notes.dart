import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flesvoieding/commonWidgetss/CommonWidgets.dart';
import 'package:flesvoieding/widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../constant/Constants.dart';

class Notes extends StatefulWidget {
  const Notes({Key, key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return addNoteDialog();
              });
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
      appBar: AppBar(
        leadingWidth: 70,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Opmerkingen',
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
                    .collection('users')
                    .doc(currentUser!.uid)
                    .collection('notes')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ));
                  } else {
                    return Expanded(
                      child: ListView(
                          children: snapshot.data!.docs.map((document) {
                        return InkWell(
                          onLongPress: () {
                            CommonWidgets.confirmBox("verwijderen",
                                "Weet je zeker dat je deze notitie wilt verwijderen?",
                                () {
                              deleteNote(document.id);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: _size.width * 0.8,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Image.asset(
                                          'assets/images/splash.png')),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          document['title'],
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                            width: _size.width * 0.5,
                                            child: Text(
                                              document['text'],
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

//////Delete Note
  deleteNote(did) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(did)
        .delete();
    CommonWidgets.toastShow("Opmerking succesvol verwijderd");
    // Navigator.pop(context);
  }
}

class addNoteDialog extends StatefulWidget {
  const addNoteDialog({Key, key}) : super(key: key);

  @override
  _addNoteDialogState createState() => _addNoteDialogState();
}

class _addNoteDialogState extends State<addNoteDialog> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _textController = new TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Dialog(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: sw,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Opmerking toevoegen',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Titel',
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormFieldWithPrefix(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  prefixIcon: Icon(
                    MdiIcons.formatTitle,
                    color: Colors.grey,
                  ),
                  hintText: 'Titel',
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Beschrijving',
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormFieldWithPrefix(
                  minLines: 5,
                  // maxLines: 10,
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  prefixIcon: Icon(
                    MdiIcons.noteText,
                    color: Colors.grey,
                  ),
                  hintText: 'Beschrijving',
                ),
                SizedBox(
                  height: 20,
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
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () async {
                              // await searchMilkDate();
                              await addNote();
                            },
                            child: Text(
                              'Opmerking toevoegen',
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
          ),
        ),
      ),
    );
  }

  addNote() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .add({
      'title': _titleController.text.toString(),
      'text': _textController.text.toString(),
      'time': DateTime.now()
    });
    Navigator.pop(context);
  }
}
