// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/home/presentation/bloc/cubit.dart';
import 'package:tz_film/home/presentation/bloc/cubit_state.dart';

Widget cartActor(
    String? title,
    String? imageg) {
  return BlocBuilder<FilmCubit, FilmCubitState>(builder: (context, state) {
    if (state is FilmLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is FilmLoaded) {
    } else {}
    return SizedBox(
      height: 200,
      width: 140,
      child: Column(
        children: [
          Container(height: 190,width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: NetworkImage('$imageg'))),
          ),Text('$title',textAlign:TextAlign.center,),
        ],
      ),
    );
  });
}

