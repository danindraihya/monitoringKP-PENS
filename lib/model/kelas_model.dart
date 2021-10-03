import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:monitoring_kp_perusahaan/utilities/AppException.dart';

class KelasModel {
  String program;
  String jurusan;

  KelasModel({this.program, this.jurusan});

  factory KelasModel.createData(Map<String, dynamic> object) {
    return KelasModel(program: object['PROGRAM'], jurusan: object['JURUSAN']);
  }

  static Future<KelasModel> connectApi(String kelas) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    try {
      var result = await http.post(apiUrl,
          body: json.encode({
            "table": "kelas",
            "data": ["*"],
            "filter": {"NOMOR": kelas}
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

            return KelasModel.createData(data);
          }
          return null;
        default:
          return throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${result.statusCode}');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
