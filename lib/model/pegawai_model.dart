import 'dart:convert';

import 'package:http/http.dart' as http;

class PegawaiModel {
  String nomor;
  String nip;
  String nama;
  String staff;
  String jabatan;
  String sex;

  PegawaiModel({this.nomor, this.nip, this.nama, this.staff, this.jabatan, this.sex});

  factory PegawaiModel.createPegawai(Map<String, dynamic> object) {
    return PegawaiModel(
        nomor: object['NOMOR'], nip: object['NIP'], nama: object['NAMA'], staff: object['STAFF'], jabatan: object['JABATAN'], sex: object['SEX']);
  }

  static Future<PegawaiModel> getDataByNip(String nip) async {

    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    var result = await http.post(apiUrl, body: json.encode({
        "table": "pegawai",
        "data": [
          "*"
        ],
        "filter": {
          "NIP": nip
        }
      }), headers: {
        "x-api-key": "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
      });

      var jsonObject = json.decode(result.body);
      
      var dataPegawai = (jsonObject as Map<String, dynamic>)['data'][0];

      return PegawaiModel.createPegawai(dataPegawai);
  }

  static Future<PegawaiModel> getDataById(String idPegawai) async {

    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    var result = await http.post(apiUrl, body: json.encode({
        "table": "pegawai",
        "data": [
          "*"
        ],
        "filter": {
          "NOMOR": idPegawai
        }
      }), headers: {
        "x-api-key": "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
      });

      var jsonObject = json.decode(result.body);
      
      var dataPegawai = (jsonObject as Map<String, dynamic>)['data'][0];

      return PegawaiModel.createPegawai(dataPegawai);
  }
}
