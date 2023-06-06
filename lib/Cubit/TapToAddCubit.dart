import 'package:bloc/bloc.dart';

import '../constants/constants.dart';

class TapToCubit extends Cubit<String> {
  TapToCubit() : super(kTapToStatusMessage); // initial state

  void update(String tapToMessage) =>
      emit(tapToMessage); // function to update download URL
}
