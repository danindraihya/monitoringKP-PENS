import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_luar_model.dart';

part 'update_monitoring_logbook_luar_state.dart';

class UpdateMonitoringLogbookLuarCubit
    extends Cubit<UpdateMonitoringLogbookLuarState> {
  UpdateMonitoringLogbookLuarCubit()
      : super(UpdateMonitoringLogbookLuarInitial());

  void editCatatan(String nomor, String catatan) async {
    emit(UpdateMonitoringLogbookLuarProcess());
    try {
      final _response =
          await MonitoringLogbookLuarModel.updateData(nomor, catatan);
      if (_response is Exception) {
        emit(UpdateMonitoringLogbookLuarFail());
      } else {
        if (_response == "sukses") {
          emit(UpdateMonitoringLogbookLuarSuccess());
        } else {
          emit(UpdateMonitoringLogbookLuarFail());
        }
      }
    } catch (error) {
      emit(UpdateMonitoringLogbookLuarFail());
    }
  }
}
