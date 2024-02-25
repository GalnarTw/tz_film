// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import '../../data/model.dart';

abstract class AboutFilmCubitState extends Equatable {
  const AboutFilmCubitState();

  @override
  List<Object> get props => [];
}

class AboutFilmEmpty extends AboutFilmCubitState {
  @override
  List<Object> get props => [];
}

class FilmLoading extends AboutFilmCubitState {
}

class FilmLoaded extends AboutFilmCubitState {
final FilmModel FilmModelparam;
final List<List<Person?>> actorOrVoise;

 const FilmLoaded(this.FilmModelparam,this.actorOrVoise);

  @override
List<Object> get props => [FilmModelparam,];
 
}

class FilmError extends AboutFilmCubitState {
  final String message;

  const FilmError({required this.message});
  
  @override
  List<Object> get props => [message];
}