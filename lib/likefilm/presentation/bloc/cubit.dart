// ignore_for_file: constant_identifier_names, non_constant_identifier_names, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/home/data/model.dart';
import 'package:tz_film/likefilm/data/model.dart';
import '/likefilm/data/http.dart';
// import '/likefilm/data/model.dart';
import '/likefilm/presentation/bloc/cubit_state.dart';
import '/likefilm/data/local_datasource.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class LikeFilmCubit extends Cubit<LikeFilmCubitState> {
  final GetFilmUrl getFilmUrl;
final LocalDataSource localDataSource=LocalDataSource();
final List<FilmDataModel> dataFilms;
List<FilmDataModel>? data=[];



  LikeFilmCubit(this.dataFilms, {required this.getFilmUrl}) : super(FilmEmpty());
  void testFilm() async {
    loadFilm();
   
  }
 void delData(FilmDataModel filmDataModel) async {
    localDataSource.delData(filmDataModel);
    if (state is FilmLoaded) {
      emit(FilmLoading());
      data?.removeWhere((item) => item.id == filmDataModel.id);
      emit(FilmLoaded(data ?? []));
    }
  }

void init()async{
   data= await localDataSource.getData();
 
if(data==null){
  localDataSource.putData(dataFilms);
  data=dataFilms;
  emit(FilmLoaded(dataFilms));
}


else{
  data!.addAll(dataFilms);
  
   emit(FilmLoaded(data!));

}

}


  void loadFilm() async {
    if (state is FilmLoading) return;
    final currentState = state;
    if (currentState is FilmLoaded) {}
    List<LikeFilmDataModel> FilmData = [];
    
    

    emit(FilmLoading());

  }
}
