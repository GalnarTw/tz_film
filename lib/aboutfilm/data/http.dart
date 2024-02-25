import 'dart:convert';
import 'package:http/http.dart' as http;
import '/aboutfilm/data/model.dart';

class GetFilmUrl {
  final http.Client client = http.Client();
  Future<FilmModel> get(int id) {
    return client.get(Uri.parse("https://api.kinopoisk.dev/v1.4/movie/$id"),
        headers: {
          'X-API-KEY': 'RHQ7FNF-7Q6M3QT-HXKX60K-J5EHP71'
        }).then((response) {
      if (response.statusCode == 200) {
        final film = json.decode(response.body);
        return FilmModel.fromJson(film);
      } else {
        throw Exception();
      }
    });
  }
}
