import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_model.dart';

part 'monitoring_logbook_state.dart';

class MonitoringLogbookCubit extends Cubit<MonitoringLogbookState> {
  MonitoringLogbookCubit() : super(MonitoringLogbookInitial());

  void getDataMonitoringLogbook(String idMahasiswa, String minggu) async {
    emit(MonitoringLogbookProcessLoaded());

    try {
      final _response =
          await MonitoringLogbookModel.connectApi(idMahasiswa, minggu);

      if (_response is Exception) {
        emit(MonitoringLogbookFailLoaded());
      } else {
        if (_response == null) {
          emit(MonitoringLogbookFailLoaded());
        } else {
          emit(MonitoringLogbookSuccessLoaded(_response));
        }
      }
    } catch (error) {
      emit(MonitoringLogbookFailLoaded());
    }
  }
}
