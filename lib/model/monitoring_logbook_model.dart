import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:monitoring_kp_perusahaan/model/pegawai_model.dart';

class MonitoringLogbookModel {
  String nomor;
  String kpDaftar;
  String setuju;
  String catatan;
  String pegawai;
  String tanggalVerifikasi;
  String namaPegawai;
  String mahasiswa;

  MonitoringLogbookModel(
      {this.nomor,
      this.kpDaftar,
      this.setuju,
      this.catatan,
      this.tanggalVerifikasi,
      this.pegawai,
      this.namaPegawai,
      this.mahasiswa});

  factory MonitoringLogbookModel.createMonitoringLogbook(
      Map<String, dynamic> object, String namaPegawai) {
    return MonitoringLogbookModel(
        nomor: object['NOMOR'],
        kpDaftar: object['KP_DAFTAR'],
        setuju: object['SETUJU'],
        catatan: object['CATATAN'],
        tanggalVerifikasi: object['TANGGAL_VERIFIKASI'],
        pegawai: object['PEGAWAI'],
        namaPegawai: namaPegawai,
        mahasiswa: object['MAHASISWA']);
  }

  static Future<MonitoringLogbookModel> connectApi(
      String mahasiswa, String minggu) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    var result = await http.post(apiUrl,
        body: json.encode({
          "table": "kp_monitoring_logbook",
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
      var response = await PegawaiModel.getDataById(data['PEGAWAI']);

      return MonitoringLogbookModel.createMonitoringLogbook(
          data, response.nama);
    } catch (error) {
      return null;
    }
  }

  static Future<MonitoringLogbookModel> getDataById(String idMonitoring) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    var result = await http.post(apiUrl,
        body: json.encode({
          "table": "kp_monitoring_logbook",
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
      var response = await PegawaiModel.getDataById(data['PEGAWAI']);

      return MonitoringLogbookModel.createMonitoringLogbook(
          data, response.nama);
    } catch (error) {
      return null;
    }
  }

  factory MonitoringLogbookModel.createDataMonitoringLecturer(
      Map<String, dynamic> object) {
    return MonitoringLogbookModel(
        kpDaftar: object['KP_DAFTAR'],
        setuju: object['SETUJU'],
        catatan: object['CATATAN'],
        pegawai: object['PEGAWAI'],
        mahasiswa: object['MAHASISWA']);
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
}
