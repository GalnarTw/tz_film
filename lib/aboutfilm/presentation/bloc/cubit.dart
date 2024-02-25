// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/aboutfilm/data/http.dart';
import 'package:tz_film/aboutfilm/presentation/bloc/cubit_state.dart';
import '/aboutfilm/data/model.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class AboutFilmCubit extends Cubit<AboutFilmCubitState> {
  final GetFilmUrl getFilmUrl;

  AboutFilmCubit({required this.getFilmUrl}) : super(AboutFilmEmpty());
  void testFilm() async {

  }


  void loadFilm(int id) async {
    
    if (state is FilmLoading) return;
    final currentState = state;
    if (currentState is FilmLoaded) {}


    emit(FilmLoading());
final List<List<Person?>> actorOrVoise=[[],[]];
    final failureOrFilmHome = await getFilmUrl.get(id);
    for(var person in failureOrFilmHome.persons){
      if(person.profession=='актеры дубляжа'){
        actorOrVoise[1].add(person);
      }
       if(person.profession=='актеры'){
        actorOrVoise[0].add(person);
      }
    }
    actorOrVoise.add(failureOrFilmHome.persons.map((e) {if(e.profession=='актеры дубляжа')return e;} ).toList());
    emit(FilmLoaded(
      failureOrFilmHome,
      actorOrVoise,
    ));

  }
}
