import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monitoring_kp_perusahaan/model/logbook_model.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_luar_model.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_model.dart';
import 'package:monitoring_kp_perusahaan/ui/logbook_kp_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PilihLogbook extends StatefulWidget {
  final String idMahasiswa;
  final String namaMahasiswa;
  final String nrpMahasiswa;

  PilihLogbook({this.idMahasiswa, this.namaMahasiswa, this.nrpMahasiswa});

  @override
  _PilihLogbookState createState() => _PilihLogbookState();
}

class _PilihLogbookState extends State<PilihLogbook> {
  List<int> listMingguKp = [];
  List<bool> statusLogbook = [];
  List<bool> statusMonitoring = [];
  final listWidget = <Widget>[];
  int mingguKp;

  void initState() {
    super.initState();

    _getMingguKp();
  }

  _getMingguKp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.mingguKp = prefs.getInt("mingguKp");
  }

  _getDataMingguKp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 1; i <= prefs.getInt("mingguKp"); i++) {
      listMingguKp.add(i);
      // await MonitoringLogbookModel.connectApi(widget.idMahasiswa, i.toString())
      //     .then((value) {
      //   if (value != null) {
      //     statusMonitoring.add(true);
      //   } else {
      //     statusMonitoring.add(false);
      //   }
      // });

      // await LogbookModel.connectApi(widget.idMahasiswa, i.toString())
      //     .then((value) {
      //   if (value != null) {
      //     statusLogbook.add(true);
      //   } else {
      //     statusLogbook.add(false);
      //   }
      // });
    }

    this.statusLogbook = await LogbookModel.getStatusLogbook(
        prefs.getInt("mingguKp"), widget.idMahasiswa);
    this.statusMonitoring =
        await MonitoringLogbookLuarModel.getStatusMonitoring(
            prefs.getInt("mingguKp"), widget.idMahasiswa);

    return 'true';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 41, 107, 1),
          title: Text('Logbook Kerja Praktek'),
        ),
        body: FutureBuilder(
            future: _getDataMingguKp(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _widgetMinggu(
                    listMingguKp, statusLogbook, statusMonitoring);
              } else {
                return SpinKitRing(
                  color: Colors.black,
                );
              }
            }));
  }

  Widget _widgetMinggu(
      List<int> minggu, List<bool> statusLogbook, List<bool> statusMonitoring) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: minggu.length,
        itemBuilder: (context, index) {
          return Container(
            height: 70,
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Minggu " + minggu[index].toString()),
                    (statusLogbook[index] == true)
                        ? (statusMonitoring[index] == true)
                            ? FlatButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LogbookKp(
                                      idMahasiswa: widget.idMahasiswa,
                                      namaMahasiswa: widget.namaMahasiswa,
                                      nrpMahasiswa: widget.nrpMahasiswa,
                                      mingguKp: minggu[index],
                                    );
                                  }));
                                },
                                child: Text('Lihat'))
                            : FlatButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LogbookKp(
                                      idMahasiswa: widget.idMahasiswa,
                                      namaMahasiswa: widget.namaMahasiswa,
                                      nrpMahasiswa: widget.nrpMahasiswa,
                                      mingguKp: minggu[index],
                                    );
                                  }));
                                },
                                child: Text(
                                  'Siap Diisi',
                                  style: TextStyle(color: Colors.green),
                                ))
                        : Text(
                            'XXX',
                            style: TextStyle(color: Colors.red),
                          )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
