import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String _url;

  NetworkHelper(this._url);

  Future getData() async {
    http.Response response = await http.get(this._url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data['rate'];
    } else {
      throw 'Can\'t GET data : ${response.statusCode}';
    }
  }
}
