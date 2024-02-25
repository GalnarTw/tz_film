// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/likefilm/data/local_datasource.dart';
import '/home/data/http.dart';
import '/home/data/model.dart';
import '/home/presentation/bloc/cubit_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class FilmCubit extends Cubit<FilmCubitState> {
  final GetFilmUrl getFilmUrl;
  final LocalDataSource localDataSource = LocalDataSource();

  FilmCubit({required this.getFilmUrl}) : super(FilmEmpty());
  void testFilm() async {
    loadFilm();
  }

  Future<void> searchButton(String text) async {
    final failureOrFilmHome = await getFilmUrl.get(text);
    await Future.delayed(const Duration(milliseconds: 300));
    emit(FilmLoaded(failureOrFilmHome));
  }

  void localLikeData(List<int> likeId) {}

  void loadFilm() async {
    if (state is FilmLoading) return;
    final currentState = state;
    if (currentState is FilmLoaded) {}
    List<FilmDataModel> FilmData = [];

    emit(FilmLoading());
    emit(FilmLoaded(
      FilmData,
    ));
    emit(FilmLoaded(
      FilmData,
    ));
  }
}
