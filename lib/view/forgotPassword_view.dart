import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/text_fields.dart';



class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key, key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  TextEditingController _emailController = new TextEditingController();
  bool loading = false;

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
          'Forgot Password',
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
              Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset('assets/images/forgotPassword.png')),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'E-mailadres ',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormFieldWithPrefix(
                keyboardType: TextInputType.emailAddress,
                readOnly: false,
                controller: _emailController,
                hintText: 'Vul je e-mailadres in',
              ),
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
                        onPressed: forgetPasssword,
                        child: loading == true ? SizedBox(
                            child: CircularProgressIndicator(color: Colors.black, strokeWidth: 1.5,),
                            height: 15.0,
                            width: 15.0,
                          ) :Text(
                          'Wachtwoord Opnieuw Instellen',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  forgetPasssword() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).whenComplete((){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(  
          backgroundColor: Theme.of(context).primaryColor,
          content: Text("Email Sent Successfully", style: TextStyle(color: Colors.black),),
      ));

      Navigator.pop(context);
    });
  }

}
