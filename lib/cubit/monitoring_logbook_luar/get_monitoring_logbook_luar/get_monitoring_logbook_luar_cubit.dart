import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_luar_model.dart';

part 'get_monitoring_logbook_luar_state.dart';

class GetMonitoringLogbookLuarCubit
    extends Cubit<GetMonitoringLogbookLuarState> {
  GetMonitoringLogbookLuarCubit() : super(GetMonitoringLogbookLuarInitial());

  void getDataMonitoringLogbookLuar(String idMahasiswa, String minggu) async {
    emit(GetMonitoringLogbookLuarProcessLoaded());

    try {
      final _response =
          await MonitoringLogbookLuarModel.connectApi(idMahasiswa, minggu);
      if (_response is Exception) {
        emit(GetMonitoringLogbookLuarFailLoaded());
      } else {
        if (_response == null) {
          emit(GetMonitoringLogbookLuarFailLoaded());
        } else {
          emit(GetMonitoringLogbookLuarSuccessLoaded(_response));
        }
      }
    } catch (error) {
      emit(GetMonitoringLogbookLuarFailLoaded());
    }
  }
}
