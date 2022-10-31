import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormFieldWithPrefix extends StatefulWidget {
  final String? hintText;
  final int? minLines;
  final String? label;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool readOnly;
  final TextInputType keyboardType;

  const CustomTextFormFieldWithPrefix({
    Key? key,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.minLines,
    this.controller,
    this.validator,
    this.onTap,
    required this.keyboardType,
    required this.readOnly
  }) : super(key: key);
  @override
  State<CustomTextFormFieldWithPrefix> createState() =>
      _CustomTextFormFieldWithPrefixState();
}

class _CustomTextFormFieldWithPrefixState
    extends State<CustomTextFormFieldWithPrefix> {
 @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textAlign: TextAlign.center,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      controller: widget.controller,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
        ),
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(fontSize:12,color:Colors.grey),
        label: widget.label != null ? Text(widget.label!) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
        ),
      ),
      validator: widget.validator ??
          (String? value) {
            if (value!.isEmpty) {
              setState(() {
              });
              return "Please fill out this feild";
            }
            return null;
          },
    );
  }
}

class CustomPasswordFormFieldWithPrefix extends StatefulWidget {
  final String? hintText;
  final int? minLines;
  final String? label;
  final Widget ?prefixIcon;
  final TextEditingController? controller;
  // final bool? obscureText;
  final String? Function(String?)? validator;
  final Color? borderColor;
  const CustomPasswordFormFieldWithPrefix({
    Key? key,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.minLines,
    this.controller,
    // this.obscureText,
    this.validator,
    this.borderColor,
  }) : super(key: key);

  @override
  State<CustomPasswordFormFieldWithPrefix> createState() =>
      _CustomPasswordFormFieldWithPrefixState();
}

class _CustomPasswordFormFieldWithPrefixState
    extends State<CustomPasswordFormFieldWithPrefix> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textAlign: TextAlign.center,
      controller: widget.controller,
      obscureText: isVisible,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        label: widget.label != null ? Text(widget.label!) : null,
          hintStyle: GoogleFonts.inter(fontSize:12,color:Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey.shade300,width: 1)
          ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          splashRadius: 15,
          icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility,color: Colors.black,),
          iconSize: 20,
        ),
      ),

      validator: widget.validator ??
          (String? value) {
            if (value!.isEmpty) {
              return "Please fill out this field";
            }
            return null;
          },
    );
  }
}


class CustomProfileTextFormFieldWithPrefix extends StatefulWidget {
  final String? hintText;
  final int? minLines;
  final String? label;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool readOnly;
  final TextInputType keyboardType;

  const CustomProfileTextFormFieldWithPrefix({
    Key? key,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.minLines,
    this.controller,
    this.validator,
    this.onTap,
    required this.keyboardType,
    required this.readOnly
  }) : super(key: key);
  @override
  State<CustomProfileTextFormFieldWithPrefix> createState() =>
      _CustomProfileTextFormFieldWithPrefixState();
}

class _CustomProfileTextFormFieldWithPrefixState
    extends State<CustomProfileTextFormFieldWithPrefix> {
 @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textAlign: TextAlign.center,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      controller: widget.controller,
      decoration: InputDecoration(
        disabledBorder:  UnderlineInputBorder (

           borderSide: BorderSide(color: Colors.grey,width: 1)
        ),
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(fontSize:12,color:Colors.grey),
        label: widget.label != null ? Text(widget.label!) : null,
        border: UnderlineInputBorder(
      
           borderSide: BorderSide(color: Colors.grey,width: 1)
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey,width: 1)
        ),
        focusedBorder: UnderlineInputBorder(
          
            borderSide: BorderSide(color: Colors.grey,width: 1)
        ),
      ),
      validator: widget.validator ??
          (String? value) {
            if (value!.isEmpty) {
              setState(() {
              });
              return "Please fill out this feild";
            }
            return null;
          },
    );
  }
}
