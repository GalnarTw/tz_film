// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import '/home/data/model.dart';

abstract class LikeFilmCubitState extends Equatable {
  const LikeFilmCubitState();

  @override
  List<Object> get props => [];
}

class FilmEmpty extends LikeFilmCubitState {
  @override
  List<Object> get props => [];
}

class FilmLoading extends LikeFilmCubitState {
}

class FilmLoaded extends LikeFilmCubitState {
final List<FilmDataModel> FilmModelList;
 const FilmLoaded(this.FilmModelList,
 );

  @override
List<Object> get props => [FilmModelList,];
 
}

class FilmError extends LikeFilmCubitState {
  final String message;

  const FilmError({required this.message});
  
  @override
  List<Object> get props => [message];
}