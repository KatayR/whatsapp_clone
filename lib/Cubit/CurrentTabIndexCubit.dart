import 'package:bloc/bloc.dart';

class CurrentTabIndexCubit extends Cubit<int> {
  CurrentTabIndexCubit() : super(1); // initial state

  void update(int newIndex) => emit(newIndex); // function to update tab index
}
