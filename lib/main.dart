// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wecode_kurdish_names/kurdish_names/screens/kurdish_names_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final items = ['item 1', 'item 2', 'item 3', 'item 4', 'item 5'];

  String? value;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KurdishNamesList(),
    );
  }
}
  // DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
  //       value: item,
  //       child: Text(
  //         item,
  //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
  //       ),
  //     );

  //      DropdownButtonHideUnderline(
  //             child: DropdownButton<String>(
  //               value: value,
  //               isExpanded: true,
  //               icon: Icon(
  //                 Icons.arrow_drop_down,
  //                 color: Colors.black,
  //               ),
  //               items: items.map(buildMenuItem).toList(),
  //               onChanged: (value) => setState(() {
  //                 this.value = value;
  //               }),
  //             ),
