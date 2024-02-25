import 'package:sqflite/sqflite.dart';
import 'package:tz_film/core/database.dart';
import 'package:tz_film/home/data/model.dart';

class LocalDataSource {
  final db = DBProvider.db;

  Future<List<FilmDataModel>?> getData() async {
    var dbData = await db.database;

    final List<Map<String, dynamic>> listFilms = await dbData.query('DB');
    if(listFilms.isEmpty)return null;
    final List<FilmDataModel> result = [];
    for (var film in listFilms) {
      result.add(FilmDataModel(
        id: film['id'],
        name: film['name'],
        year: film['year'],
        shortDescription: film['description'],
        poster: film['poster'],
        rating: film['rating'],
        isLike: (film['islike'] as int) == 1 ? true : false,
      ));

    }
    return result;
  } 
 Future<void> delData(FilmDataModel film) async {
    var dbData = await db.database;
    dbData.delete('DB',
        where: 'id = ${film.id}', 
        // whereArgs: [
        //   'id', 'name', 'year', 'description', 'poster', 'rating', 'islike'
        // ]
        );
  }

  Future<void> putData(List<FilmDataModel> films) async {
    var dbData = await db.database;

    for (var film in films) {
      await dbData.insert(
          'DB',
          {
            'id': film.id,
            'name': film.name,
            'year': film.year,
            'description': film.shortDescription,
            'poster': film.poster,
            'rating': film.rating.toInt(),
            'islike': film.isLike ? 1 : 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
