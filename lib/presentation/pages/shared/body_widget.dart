import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.fontColor = const Color.fromARGB(255, 218, 218, 218)
  });

  final String text;
  final double fontSize;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: 15,
          color: fontColor
        )  
      )
    );
  }
}