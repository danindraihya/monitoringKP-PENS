import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monitoring_kp_perusahaan/cubit/edit_catatan/edit_catatan_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/update_monitoring_logbook_luar/update_monitoring_logbook_luar_cubit.dart';
import 'package:monitoring_kp_perusahaan/ui/logbook_kp_view.dart';

class Editcatatan extends StatefulWidget {
  final String idMonitoring;
  final String idMahasiswa;
  final String namaMahasiswa;
  final String nrpMahasiswa;
  final int mingguKp;

  Editcatatan(
      {this.idMonitoring,
      this.idMahasiswa,
      this.namaMahasiswa,
      this.nrpMahasiswa,
      this.mingguKp});

  @override
  _EditcatatanState createState() => _EditcatatanState();
}

class _EditcatatanState extends State<Editcatatan> {
  TextEditingController controllerCatatan = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EditCatatanCubit>().loadCatatan(widget.idMonitoring);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 41, 107, 1),
          title: Text('Update Catatan'),
        ),
        body: BlocBuilder<EditCatatanCubit, EditCatatanState>(
          builder: (context, editCatatanState) {
            if (editCatatanState is EditCatatanProcessLoaded) {
              return SpinKitRing(color: Colors.black);
            } else if (editCatatanState is EditCatatanSuccessLoaded) {
              controllerCatatan.text = editCatatanState.data.catatan;
              return BlocConsumer<UpdateMonitoringLogbookLuarCubit,
                  UpdateMonitoringLogbookLuarState>(
                listener: (context, updateMonitoringLogbookLuarState) {
                  if (updateMonitoringLogbookLuarState
                      is UpdateMonitoringLogbookLuarFail) {
                    Fluttertoast.showToast(
                        msg: "Gagal melakukan update catatan");
                  } else if (updateMonitoringLogbookLuarState
                      is UpdateMonitoringLogbookLuarSuccess) {
                    Fluttertoast.showToast(
                        msg: "Berhasil melakukan update catatan");
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                builder: (context, updateMonitoringLogbookLuarState) {
                  if (updateMonitoringLogbookLuarState
                      is UpdateMonitoringLogbookLuarProcess) {
                    return SpinKitCircle(
                      color: Colors.black,
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(25),
                          child: TextField(
                            maxLines: 4,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            controller: controllerCatatan,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.all(15),
                          child: ButtonTheme(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: BorderSide(color: Colors.black)),
                              child: RaisedButton(
                                onPressed: () async {
                                  String catatan;
                                  if (controllerCatatan.text == "") {
                                    catatan = "-";
                                  } else {
                                    catatan = controllerCatatan.text;
                                  }
                                  context
                                      .read<UpdateMonitoringLogbookLuarCubit>()
                                      .editCatatan(
                                          widget.idMonitoring, catatan);
                                },
                                color: Color.fromRGBO(253, 184, 51, 1),
                                child: Text("Edit"),
                              )),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text('Gagal mendapatkan data');
            }
          },
        ));
  }
}
