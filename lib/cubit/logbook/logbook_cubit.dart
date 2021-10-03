import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/logbook_model.dart';

part 'logbook_state.dart';

class LogbookCubit extends Cubit<LogbookState> {
  LogbookCubit() : super(LogbookInitial());

  void getDataLogbook(String idMahasiswa, String minggu) async {
    emit(LogbookProcessLoaded());

    try {
      final _response = await LogbookModel.getListLogbook(idMahasiswa, minggu);
      if (_response is Exception) {
        emit(LogbookFailLoaded());
      } else {
        if (_response == null) {
          emit(LogbookFailLoaded());
        } else {
          emit(LogbookSuccessLoaded(_response));
        }
      }
    } catch (error) {}
  }
}
