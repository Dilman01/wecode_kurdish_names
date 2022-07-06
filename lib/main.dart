import 'package:flutter/material.dart';
import 'package:wecode_kurdish_names/src/screens/kurdish_names_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: KurdishNamesList(),
    );
  }
}
