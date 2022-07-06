import 'package:flutter/material.dart';
import 'package:wecode_kurdish_names/src/screens/kurdish_names_list.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.notoSansArabic().fontFamily),
      home: const KurdishNamesList(),
    );
  }
}
