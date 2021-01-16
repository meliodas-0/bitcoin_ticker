import 'package:bitcoin_ticker/constants.dart';
import 'package:http/http.dart' as Http;

class NetworkStats {
  static Future<dynamic> getStats(String s) async {
    Http.Response jsonData = await Http.get(s, headers: kHeader);
    if (jsonData.statusCode == 200) {
      return jsonData.body;
    } else {
      print(jsonData.statusCode);
      return null;
    }
  }
}
