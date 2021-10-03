import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/kp_daftar_detil_model.dart';
import 'package:monitoring_kp_perusahaan/model/kp_nilai_model.dart';

part 'insert_data_nilai_state.dart';

class InsertDataNilaiCubit extends Cubit<InsertDataNilaiState> {
  InsertDataNilaiCubit() : super(InsertDataNilaiInitial());
  
  void submitNilai(
      String idMahasiswa,
      String kpDaftar,
     List<double> nilai) async {
    emit(InsertDataNilaiProcess());
    
    final _dataKpDaftarDetil = await KpDaftarDetilModel.getDataByIdMahasiswa(idMahasiswa);
    String _jabatanPembimbing;
    if(_dataKpDaftarDetil.jabatanPembimbingPerusahaan == null) {
      _jabatanPembimbing = "-";
    } else {
      _jabatanPembimbing = _dataKpDaftarDetil.jabatanPembimbingPerusahaan;
    }

    final _response = await KpNilaiModel.insertDataNilaiKp(idMahasiswa, nilai, _dataKpDaftarDetil.namaPembimbingPerusahaan, _jabatanPembimbing, kpDaftar);
    
    if(_response == "gagal") {
      emit(InsertDataNilaiFail());
    } else {
      double kognitif = 0;
      double afektif = 0;
      double psikomotorik = 0;
      double kehadiran = 0;
      double laporan = 0;

      for(int i = 0; i < 16; i ++) {
        if(i < 5) {
          kognitif += nilai[i];
        } else if(i < 13) {
          afektif += nilai[i];
        } else if(i < 14) {
          psikomotorik += nilai[i];
        } else if(i < 15) {
          kehadiran += nilai[i];
        } else {
          laporan += nilai[i];
        }
      }
    
    kognitif = kognitif * 0.25 * 0.2;
    afektif = afektif * 0.25 * 0.125;
    psikomotorik = psikomotorik * 0.15;
    kehadiran = kehadiran * 0.15;
    laporan = laporan * 0.2;

      emit(InsertDataNilaiSuccess(kognitif + afektif + psikomotorik + kehadiran + laporan));
    }

  }
}
