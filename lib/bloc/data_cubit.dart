import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer/model/prayer.dart';
import '../web_services/repo.dart';

part 'data_states.dart';

class DataCubit extends Cubit<DataStates> {
  DataCubit() : super(DataCubitInitial());

  static DataCubit get(context) => BlocProvider.of(context);
  List<Prayer>? finalData = [];

  fetchData() async {
    try {
      emit(DataLoadingState());
      await ApiRepository.getData().then((values) {
        finalData!.addAll(values!);
        emit(DataLoadedState(loadedData: finalData));
      });
    } catch (error) {
      emit(DataErrorState(error: error));
      print(error);
    }
  }
}
