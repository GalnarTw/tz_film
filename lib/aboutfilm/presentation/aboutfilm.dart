// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unrelated_type_equality_checks, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/aboutfilm/data/http.dart';
import 'package:tz_film/aboutfilm/presentation/bloc/cubit.dart';
import 'package:tz_film/aboutfilm/presentation/bloc/cubit_state.dart';
import 'package:tz_film/aboutfilm/presentation/widget/cartActor.dart';
import 'package:tz_film/aboutfilm/presentation/widget/trailer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutFilmPage extends StatelessWidget {
  const AboutFilmPage({super.key, required this.idfilm});
  final idfilm;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Описание фильма',
            style: TextStyle(color: Color.fromARGB(255, 102, 46, 207), fontSize: 25, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) {
            return AboutFilmCubit(getFilmUrl: GetFilmUrl())..loadFilm(idfilm);
          },
          child: BlocBuilder<AboutFilmCubit, AboutFilmCubitState>(builder: (context, state) {
            if (state is FilmLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FilmLoaded) {
              final String? site =
                  state.FilmModelparam.videos.isNotEmpty ? '${state.FilmModelparam.videos.last}' : null;
              final String? idTrailer = site?.split('/').last;
              return ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, opacity: 0.5, image: NetworkImage(state.FilmModelparam.backdrop))),
                    // height: 2130,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, top: 15),
                          child: Stack(
                            children: [
                              Container(
                                width: 345,
                                height: 500,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover, image: NetworkImage(state.FilmModelparam.poster))),
                              ),
                              state.FilmModelparam.year == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        width: 95,
                                        height: 30,
                                        color: const Color.fromARGB(255, 102, 46, 207),
                                        child: Text(
                                          '${state.FilmModelparam.year}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 20, color: Colors.white38),
                                        ),
                                      ),
                                    ),
                              state.FilmModelparam.ageRating == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 247, top: 430),
                                      child: Container(
                                        width: 95,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 102, 46, 207),
                                            borderRadius: BorderRadius.circular(56)),
                                        child: Text(
                                          '${state.FilmModelparam.ageRating}+',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 45, color: Colors.white38),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            state.FilmModelparam.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 102, 46, 207),
                              fontWeight: FontWeight.w900,
                              fontSize: 29,
                            ),
                          ),
                        ),
                        state.FilmModelparam.description == ''
                            ? const SizedBox()
                            : const Padding(
                                padding: EdgeInsets.only(right: 270),
                                child: Text(
                                  'Сюжет: ',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 102, 46, 207),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 29,
                                  ),
                                ),
                              ),
                        state.FilmModelparam.description == ''
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        state.FilmModelparam.description,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 102, 46, 207),
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        const Padding(
                          padding: EdgeInsets.only(right: 200),
                          child: Text(
                            'Информация:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 102, 46, 207),
                              fontWeight: FontWeight.w900,
                              fontSize: 29,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                      child: Text(' Жанры:',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 102, 46, 207),
                                            fontSize: 20,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 310,
                                      child: Text('${state.FilmModelparam.genres}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 102, 46, 207),
                                            fontSize: 16,
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                      child: Text(' Общие сборы:',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 102, 46, 207),
                                            fontSize: 20,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 250,
                                      child: Text('${state.FilmModelparam.fees} \$',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 102, 46, 207),
                                            fontSize: 16,
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                      child: Text(' Дата премьеры:',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 102, 46, 207),
                                            fontSize: 20,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 230,
                                      child: Text(state.FilmModelparam.premiere.split('T').first,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 102, 46, 207),
                                            fontSize: 16,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 270),
                          child: Text(
                            'Актеры:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 102, 46, 207),
                              fontWeight: FontWeight.w900,
                              fontSize: 29,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...state.actorOrVoise[0].map((e) => cartActor(e!.name, e.photo)),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 140),
                          child: Text(
                            'Актеры дубляжа:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 102, 46, 207),
                              fontWeight: FontWeight.w900,
                              fontSize: 29,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...state.actorOrVoise[1].map((e) => cartActor(e!.name, e.photo)),
                              ],
                            ),
                          ),
                        ),
                        site != null
                            ? const Padding(
                                padding: EdgeInsets.only(right: 260),
                                child: Text(
                                  'Трейлер:',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 102, 46, 207),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 29,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        site != null
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) => PLayerScreen(videoId: idTrailer)));
                                },
                                child: Image.network(YoutubePlayer.getThumbnail(videoId: idTrailer!)))
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              );
            } else {}
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
