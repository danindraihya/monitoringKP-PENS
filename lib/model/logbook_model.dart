import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:monitoring_kp_perusahaan/utilities/AppException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogbookModel {
  String nomor;
  String kpDaftar;
  String mahasiswa;
  String tanggal;
  String jamMulai;
  String jamSelesai;
  String kegiatan;
  String sesuaiKuliah;
  String mataKuliah;
  String setuju;
  String minggu;
  String fileProgresLaporan;
  String fileFotoLaporan;
  String dataFileProgresLaporan;
  String ekstensi;

  LogbookModel(
      {this.nomor,
      this.kpDaftar,
      this.mahasiswa,
      this.tanggal,
      this.jamMulai,
      this.jamSelesai,
      this.kegiatan,
      this.sesuaiKuliah,
      this.mataKuliah,
      this.setuju,
      this.minggu,
      this.fileProgresLaporan,
      this.fileFotoLaporan,
      this.dataFileProgresLaporan,
      this.ekstensi});

  factory LogbookModel.createLogbook(Map<String, dynamic> object) {
    return LogbookModel(
      nomor: object['NOMOR'],
      kpDaftar: object['KP_DAFTAR'],
      mahasiswa: object['MAHASISWA'],
      tanggal: object['TANGGAL'],
      jamMulai: object['JAM_MULAI'],
      jamSelesai: object['JAM_SELESAI'],
      kegiatan: object['KEGIATAN'],
      sesuaiKuliah: object['SESUAI_KULIAH'],
      mataKuliah: object['MATAKULIAH'],
      setuju: object['SETUJU'],
      minggu: object['MINGGU'],
      fileProgresLaporan: object['FILE_PROGRES_LAPORAN'],
      fileFotoLaporan: object['FILE_FOTO_LAPORAN'],
      dataFileProgresLaporan: object['DATA_FILE_PROGRES_LAPORAN'],
      ekstensi: object['EKSTENSI'],
    );
  }

  static Future<List<LogbookModel>> getListLogbook(
      String idMahasiswa, String minggu) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_logbook",
            "data": ["*"],
            "filter": {"MAHASISWA": idMahasiswa, "MINGGU": minggu}
          }),
          headers: {
            "x-api-key":
                "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
          });

      var jsonObject = json.decode(result.body);

      switch (result.statusCode) {
        case 200:
          if ((jsonObject as Map<String, dynamic>)['data'].length < 1) {
            return null;
          } else {
            List<dynamic> listLogbook =
                (jsonObject as Map<String, dynamic>)['data'];

            List<LogbookModel> dataLogbook = [];
            for (int i = 0; i < listLogbook.length; i++) {
              dataLogbook.add(LogbookModel.createLogbook(listLogbook[i]));
            }

            return dataLogbook;
          }
          return null;
        default:
          return null;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  static Future<List<bool>> getStatusLogbook(
      int mingguKp, String mahasiswa) async {
    List<bool> data = [];

    for (int i = 1; i <= mingguKp; i++) {
      var dataMonitoring = await getListLogbook(mahasiswa, i.toString());
      if (dataMonitoring == null) {
        data.add(false);
      } else {
        data.add(true);
      }

      
    }
    return data;
  }
}
