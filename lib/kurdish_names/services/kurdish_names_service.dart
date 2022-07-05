import 'package:http/http.dart' as http;
import 'package:wecode_kurdish_names/kurdish_names/models/names_data_model.dart';

class KurdishNamesService {
  Future<KurdishNames> fetchListOfNames() async {
    Uri _kudishNamesUri = Uri(
        scheme: 'https',
        host: 'nawikurdi.com',
        path: 'api',
        queryParameters: {'limit': '10', 'gender': 'F', 'offset': '0'});

    http.Response _response = await http
        .get(Uri.parse('https://nawikurdi.com/api?limit=5&gender=F&offset=0'))
        .catchError((err) => print(err));

    // http.Response _response =
    //     await http.get(_kudishNamesUri).catchError((err) => print(err));

    KurdishNames _kurdishNames = KurdishNames.fromJson(_response.body);
    return _kurdishNames;
  }
}
