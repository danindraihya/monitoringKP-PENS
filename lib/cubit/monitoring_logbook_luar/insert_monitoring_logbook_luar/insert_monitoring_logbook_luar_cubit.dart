import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_luar_model.dart';

part 'insert_monitoring_logbook_luar_state.dart';

class InsertMonitoringLogbookLuarCubit extends Cubit<InsertMonitoringLogbookLuarState> {
  InsertMonitoringLogbookLuarCubit() : super(InsertMonitoringLogbookLuarInitial());

  void insertDataMonitoring(
      String idKpDaftar,
      String minggu,
      String bulan,
      String tahun,
      String catatan,
      String tanggal,
      String idMahasiswa,
      String namaPembimbing,
      String nipPembimbing) async {
    emit(InsertMonitoringLogbookLuarProcessSave());

    try {
      final _response = await MonitoringLogbookLuarModel.insertDataMonitoring(
          idKpDaftar,
          minggu,
          bulan,
          tahun,
          catatan,
          tanggal,
          idMahasiswa,
          namaPembimbing,
          nipPembimbing);

      if (_response is Exception) {
        emit(InsertMonitoringLogbookLuarFailSave());
      } else {
        if (_response == "sukses") {
          emit(InsertMonitoringLogbookLuarSuccessSave());
        } else {
          emit(InsertMonitoringLogbookLuarFailSave());
        }
      }
    } catch (error) {
      emit(InsertMonitoringLogbookLuarFailSave());
    }
  }
}
