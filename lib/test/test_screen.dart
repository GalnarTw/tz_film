import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/test/test_cubit.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TestCubit>(
      create: (context) => TestCubit(),
      child: BlocBuilder<TestCubit, TestState>(
        builder: (context, state) {
          if (state is TextState) {
            return Center(
              child: Text(state.data[0].toString()),
            );
          } else {
            return const Center(child: Text('no state'));
          }
        },
      ),
    );
  }
}
