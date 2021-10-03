import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:monitoring_kp_perusahaan/utilities/AppException.dart';

class KpDaftarDetilModel {
  String nomor;
  String kpDaftar;
  String mahasiswa;
  String namaPembimbingPerusahaan;
  String nipPembimbingPerusahaan;
  String jabatanPembimbingPerusahaan;
  String nilaiAkhirPembimbing;
  String catatan;
  String sudahRevisi;
  String urlRevisi;
  String catatanMahasiswaKeDosen;

  KpDaftarDetilModel(
      {this.nomor,
      this.kpDaftar,
      this.mahasiswa,
      this.namaPembimbingPerusahaan,
      this.nipPembimbingPerusahaan,
      this.jabatanPembimbingPerusahaan,
      this.nilaiAkhirPembimbing,
      this.catatan,
      this.sudahRevisi,
      this.urlRevisi,
      this.catatanMahasiswaKeDosen});

  factory KpDaftarDetilModel.createData(Map<String, dynamic> object) {
    return KpDaftarDetilModel(
        nomor: object['NOMOR'],
        kpDaftar: object['KP_DAFTAR'],
        mahasiswa: object['MAHASISWA'],
        namaPembimbingPerusahaan: object['NAMA_PEMBIMBING_PERUSAHAAN'],
        nipPembimbingPerusahaan: object['NIP_PEMBIMBING_PERUSAHAAN'],
        jabatanPembimbingPerusahaan: object['JABATAN_PEMBIMBING_PERUSAHAAN'],
        nilaiAkhirPembimbing: object['NA_PEMBIMBING'],
        catatan: object['CATATAN_PEMBIMBING'],
        sudahRevisi: object['SUDAH_REVISI'],
        urlRevisi: object['URL_REVISI'],
        catatanMahasiswaKeDosen: object['CATATAN_MHS_KE_DOSEN']);
  }

  static Future<KpDaftarDetilModel> getDataByIdMahasiswa(
      String idMahasiswa) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_daftar_detil",
            "data": ["*"],
            "filter": {"MAHASISWA": idMahasiswa}
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
            var data = (jsonObject as Map<String, dynamic>)['data']
                [(jsonObject as Map<String, dynamic>)['data'].length - 1];

            return KpDaftarDetilModel.createData(data);
          }
          return null;
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${result.statusCode}');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  static Future<String> setProfileDataPembimbing(
      String namaPembimbing,
      String jabatanPembimbing,
      String nipPembimbing,
      String idMahasiswa) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/update");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_daftar_detil",
            "data": {
              "NAMA_PEMBIMBING_PERUSAHAAN": namaPembimbing,
              "JABATAN_PEMBIMBING_PERUSAHAAN": jabatanPembimbing,
              "NIP_PEMBIMBING_PERUSAHAAN": nipPembimbing
            },
            "conditions": {"MAHASISWA": idMahasiswa}
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
