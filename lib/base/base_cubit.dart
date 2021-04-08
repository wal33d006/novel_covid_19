import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_states.dart';

class BaseCubit<T> extends Cubit<BaseState> {
  BaseCubit({T? initialState}) : super(BaseInitialState());

  makeACall(
      {required Function function,
      required Function(BaseErrorState) onError}) async {
    try {
      await function();
    } catch (ex) {
      print(ex.toString());
      onError(BaseErrorState(errorMessage: ex.toString()));
    }
  }
}
