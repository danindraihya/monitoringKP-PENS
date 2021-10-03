import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/kp_daftar_detil_model.dart';

part 'set_profile_state.dart';

class SetProfileCubit extends Cubit<SetProfileState> {
  SetProfileCubit() : super(SetProfileInitial());

  void setProfile(String namaPembimbing, String jabatanPembimbing,
      String nipPembimbing, String idMahasiswa) async {
    emit(SetProfileProcess());
    try {
      final _response = await KpDaftarDetilModel.setProfileDataPembimbing(
          namaPembimbing, jabatanPembimbing, nipPembimbing, idMahasiswa);
      if (_response is Exception) {
        emit(SetProfileFail());
      } else {
        if (_response == "sukses") {
          emit(SetProfileSuccess());
        } else {
          emit(SetProfileFail());
        }
      }
    } catch (error) {
      emit(SetProfileFail());
    }
  }
}
