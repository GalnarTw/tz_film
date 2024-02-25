class FilmModel {
  final String backdrop;
  final int id;
  final String name;
  final String description;
  final String premiere;
  final int year;
  final String poster;
  final List<String> genres;
  final List<Person> persons;
  final int fees;
  final int? ageRating;
  final List<String> videos;

  FilmModel(
      {required this.backdrop,
      required this.id,
      required this.name,
      required this.description,
      required this.premiere,
      required this.year,
      required this.poster,
      required this.genres,
      required this.persons,
      required this.fees,
      required this.ageRating,
      required this.videos});

  factory FilmModel.fromJson(Map<String, dynamic> json) => FilmModel(
      name: json['name'],
      backdrop: json['backdrop']['url'] ??
          'https://kinofind.1c-umi.ru/images/cms/data/design/drama.jpg',
      id: json['id'],
      description: json['description'] ?? '',
      premiere: json['premiere']['world'] ?? '',
      year: json['year'],
      poster: json['poster']['url'] ??
          'https://proprikol.ru/wp-content/uploads/2020/11/kartinki-oshibki-2.jpg',
      genres: (json['genres'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>)['name'] as String)
          .toList(),
      persons: (json['persons'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      fees: json['fees']['world']['value'] ?? 0,
      ageRating: json['ageRating'],
      videos: json['videos'] != null
          ? (json['videos']['trailers'] as List<dynamic>)
              .map((e) => (e as Map<String, dynamic>)['url'] as String)
              .toList()
          : []);
}

class Person {
  final String photo;
  final String name;
  final String profession;

  Person({
    required this.photo,
    required this.name,
    required this.profession,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        photo: json['photo'],
        name: json['name'] ?? '',
        profession: json['profession'],
      );
}
