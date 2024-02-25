import 'dart:convert';
import 'package:http/http.dart' as http;
import '/aboutfilm/data/model.dart';

class GetFilmUrl {
// GetFilmUrl(this.searchfilm);

  // final String searchfilm;

  final http.Client client = http.Client();
  Future<FilmModel> get(int id) {
    return client.get(Uri.parse("https://api.kinopoisk.dev/v1.4/movie/$id"),
        headers: {'X-API-KEY': 'RHQ7FNF-7Q6M3QT-HXKX60K-J5EHP71'}).then((response) {
      if (response.statusCode == 200) {
        final film = json.decode(response.body);
        // var result = film['docs'] as dynamic;
        // result = result.map((e) => FilmModel.fromJson(e)).toList();
        // return film as FilmModel;
        return FilmModel.fromJson(film);
      } else {
        throw Exception();
      }
    });
  }
}
