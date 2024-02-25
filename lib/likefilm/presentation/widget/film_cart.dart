// ignore_for_file: implementation_imports, must_be_immutable, unnecessary_import, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/home/data/model.dart';
import 'package:tz_film/home/presentation/bloc/cubit.dart';
import 'package:tz_film/home/presentation/bloc/cubit_state.dart';
import 'package:tz_film/likefilm/presentation/bloc/cubit.dart';
import '../../../aboutfilm/presentation/aboutfilm.dart';

class FilmCart extends StatefulWidget {
  FilmCart({
    super.key,
    required this.name,
    this.malId,
    this.title,
    this.score,
    this.year,
    this.imageg,
    required this.likeState,
  });
  final String name;
  final int? malId;
  final String? title;
  final score;
  final int? year;
  final String? imageg;
  bool likeState = false;

  @override
  State<FilmCart> createState() => _FilmCartState();
}

class _FilmCartState extends State<FilmCart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmCubit, FilmCubitState>(
      builder: (context, state) {
        if (state is FilmLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FilmLoaded) {
        } else {}
        return Padding(
          padding: const EdgeInsets.fromLTRB(4, 20, 4, 4),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutFilmPage(idfilm: widget.malId)));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: const [],
              ),
              height: 260,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(9),
                        child: Stack(
                          children: [
                            Container(
                              height: 242,
                              width: 170,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 133, 16, 195),
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 133, 16, 195)
                                            .withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 12,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.network(
                                  '${widget.imageg}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 85, top: 200),
                              child: Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 102, 46, 207),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 35,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      '${widget.score}',
                                      style: const TextStyle(
                                          color: Colors.white38,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 102, 46, 207),
                                    borderRadius: BorderRadius.circular(5)),
                                width: 95,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${widget.year} ',
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: Colors.white38)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            '${widget.name}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 102, 46, 207),
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            '${widget.title}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 102, 46, 207),
                                fontWeight: FontWeight.w700,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 210),
                    child: IconButton(
                      onPressed: () {
                        widget.likeState = !widget.likeState;
                         context.read<LikeFilmCubit>().delData(FilmDataModel(
                            name: widget.name,
                            year: widget.year!,
                            shortDescription: widget.title!,
                            id: widget.malId!,
                            poster: widget.imageg!,
                            rating: widget.score));
                        setState(() {});
                        
                      },
                      icon: Icon(
                        widget.likeState
                            ? Icons.favorite_border
                            : Icons.favorite,
                        color: const Color.fromARGB(255, 102, 46, 207),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
