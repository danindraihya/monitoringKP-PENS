import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monitoring_kp_perusahaan/model/mahasiswa_model.dart';
import 'package:monitoring_kp_perusahaan/ui/pilih_logbook_view.dart';
import 'package:monitoring_kp_perusahaan/ui/drawer.dart';
import 'package:monitoring_kp_perusahaan/ui/profile_view.dart';
import 'package:monitoring_kp_perusahaan/ui/widgets/row_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitoringKpView extends StatefulWidget {
  @override
  _MonitoringKpViewState createState() => _MonitoringKpViewState();
}

class _MonitoringKpViewState extends State<MonitoringKpView> {
  MahasiswaModel dataMahasiswa;

  final PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.5);
  final List<Color> colors = [Colors.red, Colors.green, Colors.green];

  @override
  void initState() {
    super.initState();
    _checkData();
  }

  _checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("namaPembimbingPerusahaan") == null ||
        prefs.getString("nipPembimbingPerusahaan") == null) {
      return Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Profile();
      }));
    }
  }

  _getDataMahasiswa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await MahasiswaModel.connectApi(prefs.getString("idKerjaPraktek"));
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 41, 107, 1),
          title: Text("Monitoring KP"),
        ),
        drawer: BaseDrawer(),
        body: SingleChildScrollView(
            child: FutureBuilder(
          future: _getDataMahasiswa(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _dataMahasiswa(context, (snapshot.data as MahasiswaModel));
            } else {
              return Center(
                  child: SpinKitRing(
                color: Colors.black,
              ));
            }
          },
        )));
  }

  Widget _dataMahasiswa(BuildContext context, MahasiswaModel data) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RowData(
                    atribut: "Nama",
                    isi: data.nama,
                  ),
                  RowData(
                    atribut: "NRP",
                    isi: data.nrp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonTheme(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              side: BorderSide(color: Colors.black)),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PilihLogbook(
                                  idMahasiswa: data.nomor,
                                  namaMahasiswa: data.nama,
                                  nrpMahasiswa: data.nrp,
                                );
                              }));
                            },
                            color: Color.fromRGBO(253, 184, 51, 1),
                            child: Text("Lihat"),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
