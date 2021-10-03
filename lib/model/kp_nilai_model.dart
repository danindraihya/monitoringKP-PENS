import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:monitoring_kp_perusahaan/utilities/AppException.dart';

class KpNilaiModel {
  String nomor;
  String mahasiswa;
  String kpAspekDetil;
  String skor;
  String namaPembimbing;
  String jabatanPembimbing;
  String kpDaftar;

  KpNilaiModel(
      {this.nomor,
      this.mahasiswa,
      this.kpAspekDetil,
      this.skor,
      this.namaPembimbing,
      this.jabatanPembimbing,
      this.kpDaftar});

  factory KpNilaiModel.createData(Map<String, dynamic> object) {
    return KpNilaiModel(
        nomor: object['NOMOR'],
        mahasiswa: object['MAHASISWA'],
        kpAspekDetil: object['KP_ASPEK_DETIL'],
        skor: object['SKOR'],
        namaPembimbing: object['NAMA_PEMBIMBING'],
        jabatanPembimbing: object['JABATAN_PEMBIMBING'],
        kpDaftar: object['KP_DAFTAR']);
  }

  static Future<String> insertDataNilaiKp(String idMahasiswa, List<double> skor,
      String namaPembimbing, String jabatanPembimbing, String kpDaftar) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/insert");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_nilai",
            "data": [
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 1,
                "SKOR": skor[0].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 2,
                "SKOR": skor[1].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 3,
                "SKOR": skor[2].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 4,
                "SKOR": skor[3].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 5,
                "SKOR": skor[4].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 6,
                "SKOR": skor[5].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 7,
                "SKOR": skor[6].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 8,
                "SKOR": skor[7].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 9,
                "SKOR": skor[8].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 10,
                "SKOR": skor[9].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 11,
                "SKOR": skor[10].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 12,
                "SKOR": skor[11].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 13,
                "SKOR": skor[12].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 14,
                "SKOR": skor[13].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 15,
                "SKOR": skor[14].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
              },
              {
                "MAHASISWA": idMahasiswa,
                "KP_ASPEK_DETIL": 16,
                "SKOR": skor[15].toString(),
                "NAMA_PEMBIMBING": namaPembimbing,
                "JABATAN_PEMBIMBING": jabatanPembimbing,
                "KP_DAFTAR": kpDaftar
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
            print((jsonObject as Map<String, dynamic>)['data'][0]['deskripsi']);
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

  static Future<List<KpNilaiModel>> getDataNilaiKp(String idMahasiswa) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_nilai",
            "data": ["*"],
            "filter": {"MAHASISWA": idMahasiswa},
            "limit": "50"
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
            List<dynamic> listKpNilai =
                (jsonObject as Map<String, dynamic>)['data'];

            List<KpNilaiModel> dataNilai = [];
            for (int i = 0; i < listKpNilai.length; i++) {
              dataNilai.add(KpNilaiModel.createData(listKpNilai[i]));
            }

            return dataNilai;
          }
          return null;
        default:
          return null;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  static Future<KpNilaiModel> searchNilai(
      String idMahasiswa, String kpAspekDetil) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kp_nilai",
            "data": ["*"],
            "filter": {
              "MAHASISWA": idMahasiswa,
              "KP_ASPEK_DETIL": kpAspekDetil
            },
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
            var data = (jsonObject as Map<String, dynamic>)['data'][0];

            return KpNilaiModel.createData(data);
          }
          return null;
        default:
          return null;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  static Future<String> updateData(
      String idMahasiswa, List<double> skor) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/update");

    try {
      for (int i = 1; i <= 16; i++) {
        var dataNilai = await searchNilai(idMahasiswa, i.toString());
        var result = await http.post(apiUrl,
            body: json.encode({
              "table": "kp_nilai",
              "data": {"SKOR": skor[i - 1].toString()},
              "conditions": {
                "NOMOR": dataNilai.nomor
              }
            }),
            headers: {
              "x-api-key":
                  "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
            });
        var jsonObject = json.decode(result.body);
        if ((jsonObject as Map<String, dynamic>)['data']['status'] == "gagal") {
          print((jsonObject as Map<String, dynamic>)['data']['deskripsi']);
          return "gagal";
        }
      }

      return 'sukses';
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
