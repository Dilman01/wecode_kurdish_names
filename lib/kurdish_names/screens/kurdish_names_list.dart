// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:wecode_kurdish_names/kurdish_names/models/names_data_model.dart';
import 'package:wecode_kurdish_names/kurdish_names/services/kurdish_names_service.dart';

class KurdishNamesList extends StatefulWidget {
  @override
  State<KurdishNamesList> createState() => _KurdishNamesListState();
}

class _KurdishNamesListState extends State<KurdishNamesList> {
  final genderList = ['O', 'M', 'F'];

  final limit = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '20',
    '30',
    '50'
  ];

  final sort = ['positive', 'negative'];
  bool isPositive = true;

  final KurdishNamesService _namesService = KurdishNamesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  hint: Text('Gender'),
                  items: genderList.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      _namesService.gender = value.toString();
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: Text('Sort By'),
                  items: sort.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      _namesService.sort = value.toString();
                      print(value.toString());
                      if (value.toString() == 'negative') {
                        isPositive = false;
                      } else {
                        isPositive = true;
                      }
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: Text('Limit'),
                  items: limit.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      _namesService.limit = value.toString();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              padding: EdgeInsets.all(20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: FutureBuilder<KurdishNames>(
                  future: _namesService.fetchListOfNames(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.data == null) {
                      return Text('no data');
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.names.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            leading: Text(isPositive
                                ? snapshot.data!.names[index].positive_votes
                                    .toString()
                                : snapshot.data!.names[index].negative_votes
                                    .toString()),
                            title: Text(snapshot.data!.names[index].name),
                            children: [Text(snapshot.data!.names[index].desc)],
                          );
                        });
                  }),
                ),
              ),
              // child: ,
            ),
          )
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
