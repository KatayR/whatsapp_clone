import 'package:bloc/bloc.dart';

import '../constants/constants.dart';

class DownloadUrlCubit extends Cubit<String> {
  DownloadUrlCubit() : super(kUserPpURL); // initial state

  void update(String newUrl) => emit(newUrl); // function to update download URL
}
