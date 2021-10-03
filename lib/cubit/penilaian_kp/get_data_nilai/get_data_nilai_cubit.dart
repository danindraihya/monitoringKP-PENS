import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/kp_daftar_detil_model.dart';
import 'package:monitoring_kp_perusahaan/model/kp_nilai_model.dart';
import 'package:monitoring_kp_perusahaan/model/mahasiswa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_data_nilai_state.dart';

class GetDataNilaiCubit extends Cubit<GetDataNilaiState> {
  GetDataNilaiCubit() : super(GetDataNilaiInitial());

  void loadNilai() async {
    emit(GetDataNilaiProcess());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final _dataMahasiswa =
          await MahasiswaModel.connectApi(prefs.getString("idKerjaPraktek"));

      if (_dataMahasiswa is Exception) {
        emit(GetDataNilaiFail());
      } else {
        final _dataKpNilai =
            await KpNilaiModel.getDataNilaiKp(_dataMahasiswa.nomor);
        // final _dataKpDaftarDetil =
        //     await KpDaftarDetilModel.getDataByIdMahasiswa(_dataMahasiswa.nomor);
        if (_dataKpNilai is Exception) {
          emit(GetDataNilaiFail());
        } else {
          if (_dataKpNilai == null) {
            emit(GetDataNilaiSuccess(
                totalNilaiAkhir: 0,
                namaMahasiswa: _dataMahasiswa.nama,
                nrpMahasiswa: _dataMahasiswa.nrp));
          } else {
            double kognitif = 0;
            double afektif = 0;
            double psikomotorik = 0;
            double kehadiran = 0;
            double laporan = 0;

            for (int i = 0; i <= 15; i++) {
              if (i < 5) {
                kognitif += double.parse(_dataKpNilai[i].skor);
              } else if (i < 13) {
                afektif += double.parse(_dataKpNilai[i].skor);
              } else if (i < 14) {
                psikomotorik += double.parse(_dataKpNilai[i].skor);
              } else if (i < 15) {
                kehadiran += double.parse(_dataKpNilai[i].skor);
              } else if (i < 16) {
                laporan += double.parse(_dataKpNilai[i].skor);
              }
            }

            kognitif = kognitif * 0.25 * 0.2;
            afektif = afektif * 0.25 * 0.125;
            psikomotorik = psikomotorik * 0.15;
            kehadiran = kehadiran * 0.15;
            laporan = laporan * 0.2;

            emit(GetDataNilaiSuccess(
                totalNilaiAkhir:
                    kognitif + afektif + psikomotorik + kehadiran + laporan,
                namaMahasiswa: _dataMahasiswa.nama,
                nrpMahasiswa: _dataMahasiswa.nrp));
          }
        }
      }
    } catch (error) {
      emit(GetDataNilaiFail());
    }
  }
}
