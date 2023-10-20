import 'package:http/http.dart' as http;

Future<String> fetchData(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to fetch data');
  }
}
