import 'package:tz_film/test/test_screen.dart';

import '/locator.dart';
import 'home/presentation/bloc/cubit.dart';
import 'home/presentation/bloc/cubit_state.dart';
import 'home/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'locator.dart' as di;

void main() async {
  WidgetsFlutterBinding();
  await di.init();
  runApp(const MyApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: TestScreen()),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FilmCubit>()..testFilm(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: BlocBuilder<FilmCubit, FilmCubitState>(
            builder: (context, state) {
              return const HomePage();
            },
          ),
        ),
      ),
    );
  }
}
