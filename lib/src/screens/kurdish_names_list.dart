import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wecode_kurdish_names/src/models/names_data_model.dart';
import 'package:wecode_kurdish_names/src/services/kurdish_names_service.dart';

class KurdishNamesList extends StatefulWidget {
  const KurdishNamesList({super.key});

  @override
  State<KurdishNamesList> createState() => _KurdishNamesListState();
}

class _KurdishNamesListState extends State<KurdishNamesList> {
  final genderList = ['Both', 'Male', 'Female'];

  List<String> setLimit() {
    final List<String> limit = [];

    for (int i = 1; i <= 100; i++) {
      limit.add('$i');
    }
    return limit;
  }

  final sort = ['positive', 'negative'];

  var isPositive = true;

  final KurdishNamesService _namesService = KurdishNamesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Kurdish Names'),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  hint: const Text('Gender'),
                  items: genderList.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == 'Both') {
                        _namesService.gender = 'O';
                      } else if (value == 'Male') {
                        _namesService.gender = 'M';
                      } else if (value == 'Female') {
                        _namesService.gender = 'F';
                      }
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: const Text('Sort By'),
                  items: sort.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      _namesService.sort = value!;

                      isPositive =
                          value.toString() == 'negative' ? false : true;
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: const Text('Limit'),
                  items: setLimit().map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      _namesService.limit = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: FutureBuilder<KurdishNames>(
                  future: _namesService.fetchListOfNames(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.data == null) {
                      return const Text('no data');
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.names.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            leading: Text(
                              isPositive
                                  ? snapshot.data!.names[index].positive_votes
                                      .toString()
                                  : snapshot.data!.names[index].negative_votes
                                      .toString(),
                            ),
                            title: Text(snapshot.data!.names[index].name),
                            children: [Text(snapshot.data!.names[index].desc)],
                          );
                        });
                  }),
                ),
              ),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
