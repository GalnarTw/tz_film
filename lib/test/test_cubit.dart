import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz_film/likefilm/data/local_datasource.dart';

class TestCubit extends Cubit<TestState> {
  LocalDataSource localDS = LocalDataSource();
  TestCubit() : super(InitTestState());

  // Future<List<int>> getData() {
  //   return localDS.getData();
  // }

  // void putData(List<int> data) {
  //   localDS.putData(data);
  // }

  // void init() async {
  //   final data = await getData();
  //   data.isEmpty ? putData([1, 2, 3]) : emit(TextState(data));
  // }
}

sealed class TestState {}

class InitTestState implements TestState {}

class TextState implements TestState {
  final List<int> data;

  TextState(this.data);
}
