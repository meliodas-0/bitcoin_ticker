import 'package:http/http.dart' as Http;

class NetworkStats {
  static Future<dynamic> getStats(String s) async {
    Http.Response jsonData = await Http.get(s);
    if (jsonData.statusCode == 200) {
      return jsonData.body;
    } else {
      print(jsonData.statusCode);
      return null;
    }
  }
}
