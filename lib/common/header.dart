import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5)));
  }
}
