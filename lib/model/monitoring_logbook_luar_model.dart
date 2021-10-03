import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:monitoring_kp_perusahaan/utilities/AppException.dart';

class MonitoringLogbookLuarModel {
  String nomor;
  String kpDaftar;
  String setuju;
  String catatan;
  String tanggalVerifikasi;
  String mahasiswa;

  MonitoringLogbookLuarModel(
      {this.nomor,
      this.kpDaftar,
      this.setuju,
      this.catatan,
      this.tanggalVerifikasi,
      this.mahasiswa});

  factory MonitoringLogbookLuarModel.createMonitoringLogbook(
      Map<String, dynamic> object) {
    return MonitoringLogbookLuarModel(
        nomor: object['NOMOR'],
        kpDaftar: object['KP_DAFTAR'],
        setuju: object['SETUJU'],
        catatan: object['CATATAN'],
        tanggalVerifikasi: object['TANGGAL_VERIFIKASI'],
        mahasiswa: object['MAHASISWA']);
  }

  static Future<MonitoringLogbookLuarModel> connectApi(
      String mahasiswa, String minggu) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    var result = await http.post(apiUrl,
        body: json.encode({
          "table": "kp_monitoring_logbook_luar",
          "data": ["*"],
          "filter": {"MAHASISWA": mahasiswa, "MINGGU": minggu}
        }),
        headers: {
          "x-api-key":
              "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
        });

    var jsonObject = json.decode(result.body);

    try {
      var data = (jsonObject as Map<String, dynamic>)['data'][0];

      return MonitoringLogbookLuarModel.createMonitoringLogbook(data);
    } catch (error) {
      return null;
    }
  }

  static Future<MonitoringLogbookLuarModel> getDataById(
      String idMonitoring) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    var result = await http.post(apiUrl,
        body: json.encode({
          "table": "kp_monitoring_logbook_luar",
          "data": ["*"],
          "filter": {"NOMOR": idMonitoring}
        }),
        headers: {
          "x-api-key":
              "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
        });

    var jsonObject = json.decode(result.body);

    try {
      var data = (jsonObject as Map<String, dynamic>)['data'][0];

      return MonitoringLogbookLuarModel.createMonitoringLogbook(data);
    } catch (error) {
      return null;
    }
  }

  static Future<String> insertDataMonitoring(
      String idKpDaftar,
      String minggu,
      String bulan,
      String tahun,
      String catatan,
      String tanggal,
      String idMahasiswa,
      String namaPembimbing,
      String nipPembimbing) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/insert");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_monitoring_logbook_luar",
            "data": [
              {
                "KP_DAFTAR": idKpDaftar,
                "MINGGU": minggu,
                "BULAN": bulan,
                "TAHUN": tahun,
                "SETUJU": "1",
                "CATATAN": catatan,
                "TANGGAL_VERIFIKASI": {"value": tanggal, "type": "date"},
                "MAHASISWA": idMahasiswa,
                "NAMA_PEMBIMBING": namaPembimbing,
                "NIP_PEMBIMBING": nipPembimbing
              }
            ]
          }),
          headers: {
            "x-api-key":
                "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
          });

      var jsonObject = json.decode(result.body);

      switch (result.statusCode) {
        case 200:
          if ((jsonObject as Map<String, dynamic>)['data'][0]['status'] ==
              "sukses") {
            return "sukses";
          } else {
            return "gagal";
          }
          return "gagal";
        default:
          return "gagal";
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  static Future<List<bool>> getStatusMonitoring(
      int mingguKp, String mahasiswa) async {
    List<bool> data = [];

    for (int i = 1; i <= mingguKp; i++) {
      var dataMonitoring = await connectApi(mahasiswa, i.toString());
      if (dataMonitoring == null) {
        data.add(false);
      } else {
        data.add(true);
      }
    }

    return data;
  }

  static Future<String> updateData(String nomor, String catatan) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/update");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_monitoring_logbook_luar",
            "data": {
              "CATATAN": catatan
            },
            "conditions": {"NOMOR": nomor}
          }),
          headers: {
            "x-api-key":
                "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
          });

      var jsonObject = json.decode(result.body);

      switch (result.statusCode) {
        case 200:
          if ((jsonObject as Map<String, dynamic>)['data']["status"] ==
              "gagal") {
            return "gagal";
          } else {
            return "sukses";
          }
          return "gagal";
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${result.statusCode}');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  static Future<String> deleteData(String nomor) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/delete");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_monitoring_logbook_luar",
            "conditions": {"NOMOR": nomor}
          }),
          headers: {
            "x-api-key":
                "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
          });

      var jsonObject = json.decode(result.body);

      switch (result.statusCode) {
        case 200:
          if ((jsonObject as Map<String, dynamic>)['data']["status"] ==
              "gagal") {
            return "gagal";
          } else {
            return "sukses";
          }
          return "gagal";
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${result.statusCode}');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
