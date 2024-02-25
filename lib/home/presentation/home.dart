import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/home/data/http.dart';
import 'package:tz_film/home/data/model.dart';
import 'package:tz_film/home/presentation/bloc/cubit.dart';
import 'package:tz_film/home/presentation/bloc/cubit_state.dart';
import 'package:tz_film/home/presentation/widget/film_cart.dart';
import '../../likefilm/presentation/like.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerFild = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) {
          return FilmCubit(getFilmUrl: GetFilmUrl());
        },
        child: BlocConsumer<FilmCubit, FilmCubitState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            if (state is FilmLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FilmLoaded || state is FilmEmpty) {
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Поиск фильмов',
                        style:
                            TextStyle(color: Color.fromARGB(255, 102, 46, 207)),
                      ),
                      IconButton(
                          onPressed: () {
                            if (state is FilmLoaded) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                // idfilm:
                                final result = <FilmDataModel>[];
                                state.FilmModelList.map((e) {
                                  if (e.isLike) {
                                    result.add(e);
                                  }
                                }).toList();
                                return LikePage(
                                  localModel: result,
                                );
                              }));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const LikePage(localModel: [])));
                            }
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 102, 46, 207),
                          ))
                    ],
                  ),
                  centerTitle: true,
                ),
                body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 1,
                          image: NetworkImage(
                              'https://kinofind.1c-umi.ru/images/cms/data/design/drama.jpg'))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                height: 55,
                                width: 315,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, right: 10),
                                  child: TextField(
                                    controller: controllerFild,
                                    onChanged: ((value) {
                                      if (controllerFild.text.length >= 3) {
                                        context
                                            .read<FilmCubit>()
                                            .searchButton(controllerFild.text);
                                      }
                                    }),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromARGB(255, 102, 46, 207)),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  context
                                      .read<FilmCubit>()
                                      .searchButton(controllerFild.text);
                                },
                                child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Icon(
                                      Icons.search,
                                      size: 45,
                                    )))
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            if (state is FilmLoaded)
                              ...state.FilmModelList.map(
                                (e) => FilmCart(
                                  name: e.name,
                                  malId: e.id,
                                  title: e.shortDescription,
                                  score: e.rating,
                                  year: e.year,
                                  imageg: e.poster,
                                  likeState: false,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
