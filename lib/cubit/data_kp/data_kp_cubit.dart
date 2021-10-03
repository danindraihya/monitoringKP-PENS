import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/kp_daftar_detil_model.dart';
import 'package:monitoring_kp_perusahaan/model/mahasiswa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'data_kp_state.dart';

class DataKpCubit extends Cubit<DataKpState> {
  DataKpCubit() : super(DataKpProcessLoaded());

  void getDataKp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final _dataMahasiswa =
          await MahasiswaModel.connectApi(prefs.getString("idKerjaPraktek"));

      final _dataKpDaftarDetil =
          await KpDaftarDetilModel.getDataByIdMahasiswa(_dataMahasiswa.nomor);

      await prefs.setString("idMahasiswa", _dataMahasiswa.nomor);

      if (_dataKpDaftarDetil is Exception) {
        emit(DataKpFailLoaded());
      } else {
        if (_dataKpDaftarDetil.namaPembimbingPerusahaan != null) {
          await prefs.setString("namaPembimbingPerusahaan",
              _dataKpDaftarDetil.namaPembimbingPerusahaan);
          await prefs.setString("nipPembimbingPerusahaan",
              _dataKpDaftarDetil.nipPembimbingPerusahaan);
          await prefs.setString("jabatanPembimbingPerusahaan",
              _dataKpDaftarDetil.jabatanPembimbingPerusahaan);
        } else {
          await prefs.remove("namaPembimbingPerusahaan");

          await prefs.remove("nipPembimbingPerusahaan");

          await prefs.remove("jabatanPembimbingPerusahaan");
        }

        if (_dataKpDaftarDetil != null) {
          await prefs.setString("idKpDaftar", _dataKpDaftarDetil.kpDaftar);
          emit(DataKpSuccessLoaded(
              namaPembimbingPerusahaan:
                  _dataKpDaftarDetil.namaPembimbingPerusahaan,
              nipPembimbingPerusahaan:
                  _dataKpDaftarDetil.nipPembimbingPerusahaan,
              jabatanPembimbingPerusahaan:
                  _dataKpDaftarDetil.jabatanPembimbingPerusahaan));
        } else {
          emit(DataKpFailLoaded());
        }
      }
    } catch (error) {
      print(error);
      emit(DataKpFailLoaded());
    }
  }
}
