import 'dart:convert';

import 'package:http/http.dart' as http;

class MonitoringModel {
  String id;
  String email;

  MonitoringModel({this.id, this.email});

  factory MonitoringModel.getStatus(Map<String, dynamic> object) {
    return MonitoringModel(
      id: object['id'].toString() ,
      email: object['email']
    );
  }

  static Future<MonitoringModel> connectToApi(int id) async {

    var url = Uri.parse('https://reqres.in/api/users/' + id.toString());

    var res = await http.get(url);
    var jsonObject = json.decode(res.body);
    var dataUser = (jsonObject as Map<String, dynamic>)['data'];

    return MonitoringModel.getStatus(dataUser);
  }
}