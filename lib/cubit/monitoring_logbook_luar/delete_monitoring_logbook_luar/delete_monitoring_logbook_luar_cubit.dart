import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_luar_model.dart';

part 'delete_monitoring_logbook_luar_state.dart';

class DeleteMonitoringLogbookLuarCubit
    extends Cubit<DeleteMonitoringLogbookLuarState> {
  DeleteMonitoringLogbookLuarCubit()
      : super(DeleteMonitoringLogbookLuarInitial());

  void deleteCatatan(String nomor) async {
    emit(DeleteMonitoringLogbookLuarProcess());
    try {
      final _response = await MonitoringLogbookLuarModel.deleteData(nomor);
      if (_response is Exception) {
        emit(DeleteMonitoringLogbookLuarFail());
      } else {
        if (_response == "sukses") {
          emit(DeleteMonitoringLogbookLuarSuccess());
        } else {
          emit(DeleteMonitoringLogbookLuarFail());
        }
      }
    } catch (error) {
      emit(DeleteMonitoringLogbookLuarFail());
    }
  }
}
