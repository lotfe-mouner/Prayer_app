part of 'data_cubit.dart';


abstract class DataStates {}

class DataCubitInitial extends DataStates {}

class DataLoadingState extends DataStates {}

class DataLoadedState extends DataStates {
  final List<Prayer>? loadedData;

  DataLoadedState({required this.loadedData});
}

class DataErrorState extends DataStates {
  final dynamic error;

  DataErrorState({required this.error});
}
