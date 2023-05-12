import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizDataRepository {
  final String url;
  QuizDataRepository(this.url);

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      String data = response.body;
      return jsonDecode(data);
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }
}
