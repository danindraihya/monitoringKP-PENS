import 'dart:convert';

import 'package:http/http.dart' as http;

class KpLamaWaktuModel {
  String kpJenis;

  KpLamaWaktuModel({this.kpJenis});

  factory KpLamaWaktuModel.createData(Map<String, dynamic> object) {
    return KpLamaWaktuModel(kpJenis: object['KP_JENIS']);
  }

  static Future<KpLamaWaktuModel> connectApi(
      String program, String jurusan) async {
    var apiUrl = Uri.parse("https://online.mis.pens.ac.id/API_PENS/v1/read");

    var result = await http.post(apiUrl,
        body: json.encode({
          "table": "kp_lama_waktu",
          "data": ["*"],
          "filter": {"PROGRAM": program, "JURUSAN": jurusan}
        }),
        headers: {
          "x-api-key":
              "PENS-eErj7e6wVlZVAArk8Vval.FXoUeVkKuxDH2mNgl7pDqQt2IvpyY7a"
        });

    var jsonObject = json.decode(result.body);

    try {
      var data = (jsonObject as Map<String, dynamic>)['data'][0];

      return KpLamaWaktuModel.createData(data);
    } catch (error) {

      return null;
    }
  }
}
