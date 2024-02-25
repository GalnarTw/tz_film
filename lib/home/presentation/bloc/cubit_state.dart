// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:equatable/equatable.dart';
import '/home/data/model.dart';

abstract class FilmCubitState extends Equatable {
  const FilmCubitState();

  @override
  List<Object> get props => [];
}

class FilmEmpty extends FilmCubitState {
  @override
  List<Object> get props => [];
}

class FilmLoading extends FilmCubitState {}

class FilmLoaded extends FilmCubitState {
  List<FilmDataModel> FilmModelList;

  FilmLoaded(
    this.FilmModelList,
  );

  @override
  List<Object> get props => [
        FilmModelList,
      ];
}

class FilmError extends FilmCubitState {
  final String message;

  const FilmError({required this.message});

  @override
  List<Object> get props => [message];
}
