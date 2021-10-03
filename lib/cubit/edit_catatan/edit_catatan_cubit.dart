import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_luar_model.dart';

part 'edit_catatan_state.dart';

class EditCatatanCubit extends Cubit<EditCatatanState> {
  EditCatatanCubit() : super(EditCatatanProcessLoaded());

  void loadCatatan(String idMonitoring) async {
    final _response =
        await MonitoringLogbookLuarModel.getDataById(idMonitoring);
    print(_response);

    if (_response is Exception) {
      emit(EditCatatanFailLoaded());
    } else {
      emit(EditCatatanSuccessLoaded(_response));
    }
  }
}
