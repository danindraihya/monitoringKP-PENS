import 'dart:convert';

import 'package:http/http.dart' as http;

class KpLogbookJadwal {
  String tanggalAwal;
  String tanggalAkhir;

  KpLogbookJadwal({this.tanggalAwal, this.tanggalAkhir});

  factory KpLogbookJadwal.getData(Map<String, dynamic> object) {
    return KpLogbookJadwal(tanggalAwal: object['TANGGAL_AWAL'], tanggalAkhir: object['TANGGAL_AKHIR']);
  }

  static Future<KpLogbookJadwal> connectApi(String tahun, String semester, String kpJenis) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    var result = await http.post(apiUrl, body: json.encode({
        "table": "kp_logbook_jadwal",
        "data": [
          "*"
        ],
        "filter": {
          "TAHUN": tahun,
          "SEMESTER": semester,
          "KP_JENIS": kpJenis
        }
      }), headers: {
          "x-api-key": "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
      });

    var jsonObject = json.decode(result.body);
    var data = (jsonObject as Map<String, dynamic>)['data'][0];

    return KpLogbookJadwal.getData(data);
  
  }
}