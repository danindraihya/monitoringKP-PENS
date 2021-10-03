import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:monitoring_kp_perusahaan/utilities/AppException.dart';
import 'dart:io';

class MahasiswaModel {
  String nomor;
  String nrp;
  String nama;
  String kelas;
  String idKerjaPraktek;

  MahasiswaModel(
      {this.nomor, this.nrp, this.nama, this.kelas, this.idKerjaPraktek});

  factory MahasiswaModel.getMahasiswa(Map<String, dynamic> object) {
    return MahasiswaModel(
        nomor: object['NOMOR'],
        nrp: object['NRP'],
        nama: object['NAMA'],
        kelas: object['KELAS'],
        idKerjaPraktek: object['ID_KERJA_PRAKTEK']);
  }

  static Future<MahasiswaModel> connectApi(String idKerjaPraktek) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "mahasiswa",
            "data": ["*"],
            "filter": {"ID_KERJA_PRAKTEK": idKerjaPraktek}
          }),
          headers: {
            "x-api-key":
                "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
          }).timeout(Duration(seconds: 10));

      var jsonObject = json.decode(result.body);

      switch (result.statusCode) {
        case 200:
          if ((jsonObject as Map<String, dynamic>)['data'].length < 1) {
            return null;
          } else {
            var dataMahasiswa = (jsonObject as Map<String, dynamic>)['data'][0];
            return MahasiswaModel.getMahasiswa(dataMahasiswa);
          }
          return null;
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${result.statusCode}');
      }
    } catch(error) {
      throw Exception('Connection Error');
    }
  }
}
