import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/kelas_model.dart';
import 'package:monitoring_kp_perusahaan/model/kp_lama_waktu_model.dart';
import 'package:monitoring_kp_perusahaan/model/kp_logbook_jadwal.dart';
import 'package:monitoring_kp_perusahaan/model/mahasiswa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'minggu_kp_state.dart';

class MingguKpCubit extends Cubit<MingguKpState> {
  MingguKpCubit() : super(MingguKpInitial());

  void getDataMingguKp() async {
    emit(MingguKpProcessLoaded());
    var _dataKelas;
    var _lamaKp;
    var _kpLogbookJadwal;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final _dataMahasiswa =
          await MahasiswaModel.connectApi(prefs.getString("idKerjaPraktek"));

      if (_dataMahasiswa is Exception) {
        emit(MingguKpFailLoaded());
      } else {

        _dataKelas = await KelasModel.connectApi(_dataMahasiswa.kelas);
        await prefs.setString("program", _dataKelas.program);
        await prefs.setString("jurusan", _dataKelas.jurusan);

        _lamaKp = await KpLamaWaktuModel.connectApi(
            _dataKelas.program, _dataKelas.jurusan);
        

        if (_lamaKp is Exception) {

          emit(MingguKpFailLoaded());
        } else {
          
          await prefs.setString("lamaKp", _lamaKp.kpJenis);
          if (_lamaKp != null) {
            DateTime now = new DateTime.now();
            // DateTime now = new DateTime(2021, 2, 8);

            if (now.month == 1 ||
                now.month == 2 ||
                now.month == 3 ||
                now.month == 4 ||
                now.month == 5 ||
                now.month == 6) {
              _kpLogbookJadwal = await KpLogbookJadwal.connectApi(
                  (now.year - 1).toString(), "2", _lamaKp.kpJenis);

              if (_kpLogbookJadwal is Exception) {
                emit(MingguKpFailLoaded());
              } else {
                String dayAwal = _kpLogbookJadwal.tanggalAwal.substring(0, 2);
                int monthAwal = 0;
                switch (_kpLogbookJadwal.tanggalAwal.substring(3, 6)) {
                  case 'JAN':
                    {
                      monthAwal = 1;
                    }
                    break;

                  case 'FEB':
                    {
                      monthAwal = 2;
                    }
                    break;

                  case 'MAR':
                    {
                      monthAwal = 3;
                    }
                    break;

                  case 'APR':
                    {
                      monthAwal = 4;
                    }
                    break;

                  case 'MAY':
                    {
                      monthAwal = 5;
                    }
                    break;

                  case 'JUN':
                    {
                      monthAwal = 6;
                    }
                    break;

                  case 'JUL':
                    {
                      monthAwal = 7;
                    }
                    break;

                  case 'AUG':
                    {
                      monthAwal = 8;
                    }
                    break;

                  case 'SEP':
                    {
                      monthAwal = 9;
                    }
                    break;

                  case 'OCT':
                    {
                      monthAwal = 10;
                    }
                    break;

                  case 'NOV':
                    {
                      monthAwal = 11;
                    }
                    break;

                  case 'DEC':
                    {
                      monthAwal = 12;
                    }
                    break;

                  default:
                    {
                      monthAwal = 0;
                    }
                    break;
                }

                String yearAwal = _kpLogbookJadwal.tanggalAwal.substring(7, 9);
                yearAwal = "20" + yearAwal;

                String dayAkhir = _kpLogbookJadwal.tanggalAkhir.substring(0, 2);
                int monthAkhir;
                switch (_kpLogbookJadwal.tanggalAkhir.substring(3, 6)) {
                  case 'JAN':
                    {
                      monthAkhir = 1;
                    }
                    break;

                  case 'FEB':
                    {
                      monthAkhir = 2;
                    }
                    break;

                  case 'MAR':
                    {
                      monthAkhir = 3;
                    }
                    break;

                  case 'APR':
                    {
                      monthAkhir = 4;
                    }
                    break;

                  case 'MAY':
                    {
                      monthAkhir = 5;
                    }
                    break;

                  case 'JUN':
                    {
                      monthAkhir = 6;
                    }
                    break;

                  case 'JUL':
                    {
                      monthAkhir = 7;
                    }
                    break;

                  case 'AUG':
                    {
                      monthAkhir = 8;
                    }
                    break;

                  case 'SEP':
                    {
                      monthAkhir = 9;
                    }
                    break;

                  case 'OCT':
                    {
                      monthAkhir = 10;
                    }
                    break;

                  case 'NOV':
                    {
                      monthAkhir = 11;
                    }
                    break;

                  case 'DEC':
                    {
                      monthAkhir = 12;
                    }
                    break;

                  default:
                    {
                      monthAkhir = 0;
                    }
                    break;
                }
                String yearAkhir =
                    _kpLogbookJadwal.tanggalAkhir.substring(7, 9);
                yearAkhir = "20" + yearAkhir;

                int count = 1;
                //waktu sekarang
                DateTime now = new DateTime.now();

                //untuk testing
                // DateTime now = new DateTime(2021, 2, 8);

                DateTime dateStart = new DateTime(
                    int.parse(yearAwal), monthAwal, int.parse(dayAwal));
                DateTime dateEnd = new DateTime(
                    int.parse(yearAkhir), monthAkhir, int.parse(dayAkhir));
                if (now.compareTo(dateEnd) >= 0) {
                  if (int.parse(prefs.getString("lamaKp")) == 1) {
                    count = 4;
                  } else if (int.parse(prefs.getString("lamaKp")) == 3) {
                    count = 13;
                  } else {
                    count = 26;
                  }
                } else if (now.compareTo(dateStart) <= 0) {
                  count = 0;
                } else {
                  while (now.compareTo(dateStart) >= 0) {
                    dateStart = DateTime(
                        dateStart.year, dateStart.month, dateStart.day + 7);
                    count++;
                    if (dateStart.compareTo(now) >= 0) {
                      break;
                    }
                  }
                }
                await prefs.setInt("mingguKp", count);
                emit(MingguKpSuccessLoaded());
              }
            } else {
              _kpLogbookJadwal = await KpLogbookJadwal.connectApi(
                  (now.year).toString(), "1", _lamaKp.kpJenis);

              if (_kpLogbookJadwal is Exception) {
                emit(MingguKpFailLoaded());
              } else {
                String dayAwal = _kpLogbookJadwal.tanggalAwal.substring(0, 2);
                int monthAwal = 0;
                switch (_kpLogbookJadwal.tanggalAwal.substring(3, 6)) {
                  case 'JAN':
                    {
                      monthAwal = 1;
                    }
                    break;

                  case 'FEB':
                    {
                      monthAwal = 2;
                    }
                    break;

                  case 'MAR':
                    {
                      monthAwal = 3;
                    }
                    break;

                  case 'APR':
                    {
                      monthAwal = 4;
                    }
                    break;

                  case 'MAY':
                    {
                      monthAwal = 5;
                    }
                    break;

                  case 'JUN':
                    {
                      monthAwal = 6;
                    }
                    break;

                  case 'JUL':
                    {
                      monthAwal = 7;
                    }
                    break;

                  case 'AUG':
                    {
                      monthAwal = 8;
                    }
                    break;

                  case 'SEP':
                    {
                      monthAwal = 9;
                    }
                    break;

                  case 'OCT':
                    {
                      monthAwal = 10;
                    }
                    break;

                  case 'NOV':
                    {
                      monthAwal = 11;
                    }
                    break;

                  case 'DEC':
                    {
                      monthAwal = 12;
                    }
                    break;

                  default:
                    {
                      monthAwal = 0;
                    }
                    break;
                }

                String yearAwal = _kpLogbookJadwal.tanggalAwal.substring(7, 9);
                yearAwal = "20" + yearAwal;

                String dayAkhir = _kpLogbookJadwal.tanggalAkhir.substring(0, 2);
                int monthAkhir;
                switch (_kpLogbookJadwal.tanggalAkhir.substring(3, 6)) {
                  case 'JAN':
                    {
                      monthAkhir = 1;
                    }
                    break;

                  case 'FEB':
                    {
                      monthAkhir = 2;
                    }
                    break;

                  case 'MAR':
                    {
                      monthAkhir = 3;
                    }
                    break;

                  case 'APR':
                    {
                      monthAkhir = 4;
                    }
                    break;

                  case 'MAY':
                    {
                      monthAkhir = 5;
                    }
                    break;

                  case 'JUN':
                    {
                      monthAkhir = 6;
                    }
                    break;

                  case 'JUL':
                    {
                      monthAkhir = 7;
                    }
                    break;

                  case 'AUG':
                    {
                      monthAkhir = 8;
                    }
                    break;

                  case 'SEP':
                    {
                      monthAkhir = 9;
                    }
                    break;

                  case 'OCT':
                    {
                      monthAkhir = 10;
                    }
                    break;

                  case 'NOV':
                    {
                      monthAkhir = 11;
                    }
                    break;

                  case 'DEC':
                    {
                      monthAkhir = 12;
                    }
                    break;

                  default:
                    {
                      monthAkhir = 0;
                    }
                    break;
                }
                String yearAkhir =
                    _kpLogbookJadwal.tanggalAkhir.substring(7, 9);
                yearAkhir = "20" + yearAkhir;

                int count = 0;
                //waktu sekarang
                DateTime now = new DateTime.now();

                //untuk testing
                // DateTime now = new DateTime(2021, 2, 8);

                DateTime dateStart = new DateTime(
                    int.parse(yearAwal), monthAwal, int.parse(dayAwal));
                DateTime dateEnd = new DateTime(
                    int.parse(yearAkhir), monthAkhir, int.parse(dayAkhir));
                if (now.compareTo(dateEnd) >= 0) {
                  if (int.parse(prefs.getString("lamaKp")) == 1) {
                    count = 4;
                  } else if (int.parse(prefs.getString("lamaKp")) == 3) {
                    count = 13;
                  } else {
                    count = 26;
                  }
                } else if (now.compareTo(dateStart) <= 0) {
                  count = 0;
                } else {
                  while (now.compareTo(dateStart) >= 0) {
                    dateStart = DateTime(
                        dateStart.year, dateStart.month, dateStart.day + 7);
                    count++;
                    if (dateStart.compareTo(now) >= 0) {
                      break;
                    }
                  }
                }
                await prefs.setInt("mingguKp", count);
                emit(MingguKpSuccessLoaded());
              }
            }
          } else {
            emit(MingguKpFailLoaded());
          }
        }
      }
    } catch (error) {
      print(error);
      emit(MingguKpFailLoaded());
    }
  }
}
