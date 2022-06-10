import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
       //padding: EdgeInsets.only( left:75,right:70,bottom: 20),
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onClicked,
        child: Text(
          text,
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 17.5),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xFF005b71),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
        ),
      ));
}
