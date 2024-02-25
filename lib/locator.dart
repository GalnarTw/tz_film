import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'home/data/http.dart';
import 'home/presentation/bloc/cubit.dart';
final sl = GetIt.instance;
Future<void> init() async {
  //BLOC / Cubit
  sl.registerFactory(
    () => FilmCubit(
      getFilmUrl: sl(),
    ),
  );
 
  //UseCases
  sl.registerLazySingleton(
      () => GetFilmUrl());

  
  //External
  sl.registerLazySingleton(() => http.Client());
}