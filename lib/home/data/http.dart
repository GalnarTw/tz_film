import 'dart:convert';
import 'package:http/http.dart' as http;
import '/home/data/model.dart';

class GetFilmUrl {

  final http.Client client = http.Client();
  Future<List<FilmDataModel>> get(String searchfilm) {
    return client.get(Uri.parse("https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=10&query=$searchfilm"),
        headers: {'X-API-KEY': 'RHQ7FNF-7Q6M3QT-HXKX60K-J5EHP71'}).then((response) {
      if (response.statusCode == 200) {
        final film = json.decode(response.body);
        var result = film['docs'] as List<dynamic>;
        result = result.map((e) => FilmDataModel.fromJson(e)).toList();
        return result as List<FilmDataModel>;
      } else {
        throw Exception();
      }
    });
  }
}
