

class LikeFilmDataModel {
  final int id;
  final String name;
  final int year;
  final String shortDescription;
  final String poster;
  final num rating;

  LikeFilmDataModel({
    required this.name,
    required this.year,
    required this.shortDescription,
    required this.id,
    required this.poster,
    required this.rating,
  });

  factory LikeFilmDataModel.fromJson(Map<String, dynamic> json) => LikeFilmDataModel(
        id: json['id'],
        name: json['name'],
        year: json['year'],
        shortDescription: json['shortDescription'],
        poster: json['poster']['url']??'https://proprikol.ru/wp-content/uploads/2020/11/kartinki-oshibki-2.jpg',
       
        rating: json['rating']['imdb'] is int ? (json['rating']['imdb'] as int).toDouble() : json['rating']['imdb']);
      
}
