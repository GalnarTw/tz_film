class FilmDataModel {
  final int id;
  final String name;
  final int year;
  final String shortDescription;
  final String poster;
  final num rating;
  bool isLike;

  FilmDataModel({
    required this.name,
    required this.year,
    required this.shortDescription,
    required this.id,
    required this.poster,
    required this.rating,
    this.isLike = false,
  });

  factory FilmDataModel.fromJson(Map<String, dynamic> json) => FilmDataModel(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      shortDescription: json['shortDescription'],
      poster: json['poster']['url'] ?? 'https://proprikol.ru/wp-content/uploads/2020/11/kartinki-oshibki-2.jpg',
      rating: json['rating']['imdb'] is int ? (json['rating']['imdb'] as int).toDouble() : json['rating']['imdb']);
}
