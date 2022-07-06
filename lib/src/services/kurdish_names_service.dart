import 'package:http/http.dart' as http;
import 'package:wecode_kurdish_names/src/models/names_data_model.dart';

class KurdishNamesService {
  String gender = 'O';
  String limit = '10';
  String sort = 'positive';

  Future<KurdishNames> fetchListOfNames() async {
    Uri _kudishNamesUri = Uri(
        scheme: 'https',
        host: 'nawikurdi.com',
        path: 'api',
        queryParameters: {
          'limit': limit,
          'gender': gender,
          'offset': '0',
          'sort': sort,
        });

    // http.Response _response = await http
    //     .get(Uri.parse('https://nawikurdi.com/api?limit=5&gender=F&offset=0'))
    //     .catchError((err) => print(err));

    http.Response _response =
        await http.get(_kudishNamesUri).catchError((err) => print(err));

    KurdishNames _kurdishNames = KurdishNames.fromJson(_response.body);
    return _kurdishNames;
  }
}
