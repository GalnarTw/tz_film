import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/data/model.dart';
import '/likefilm/data/http.dart';
import '/likefilm/presentation/bloc/cubit.dart';
import '/likefilm/presentation/bloc/cubit_state.dart';
import 'widget/film_cart.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key, required this.localModel});
  final List<FilmDataModel> localModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Избранное',
            style: TextStyle(color: Color.fromARGB(255, 102, 46, 207)),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) {
            return LikeFilmCubit(localModel, getFilmUrl: GetFilmUrl())..init();
          },
          child: BlocBuilder<LikeFilmCubit, LikeFilmCubitState>(
            builder: (context, state) {
              if (state is FilmLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FilmLoaded) {
              } else {}
              return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        opacity: 1,
                        image: NetworkImage(
                            'https://kinofind.1c-umi.ru/images/cms/data/design/drama.jpg'))),
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
                      )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
