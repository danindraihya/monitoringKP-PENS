import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monitoring_kp_perusahaan/cubit/checkbox/checkbox_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/logbook/logbook_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook/monitoring_logbook_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/delete_monitoring_logbook_luar/delete_monitoring_logbook_luar_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/get_monitoring_logbook_luar/get_monitoring_logbook_luar_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/insert_monitoring_logbook_luar/insert_monitoring_logbook_luar_cubit.dart';
import 'package:monitoring_kp_perusahaan/model/logbook_model.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_luar_model.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_logbook_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_catatan_view.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class LogbookKp extends StatefulWidget {
  final String idMahasiswa;
  final String namaMahasiswa;
  final String nrpMahasiswa;
  final int mingguKp;

  LogbookKp(
      {this.idMahasiswa, this.namaMahasiswa, this.nrpMahasiswa, this.mingguKp});

  @override
  _LogbookKpState createState() => _LogbookKpState();
}

class _LogbookKpState extends State<LogbookKp> {
  TextEditingController _controllerCatatan = TextEditingController();

  bool setujuSubmit = false;

  // Future<List<LogbookModel>> _getDataLogbook() async {
  //   final response = await LogbookModel.getListLogbook(
  //       widget.idMahasiswa, widget.mingguKp.toString());

  //   return response;
  // }

  // Future<MonitoringLogbookLuarModel> _getDataCatatan() async {
  //   final response = await MonitoringLogbookLuarModel.connectApi(
  //       widget.idMahasiswa, widget.mingguKp.toString());

  //   return response;
  // }

  // Future<MonitoringLogbookModel> _getCatatanPembimbingKampus() async {
  //   final _response = await MonitoringLogbookModel.connectApi(
  //       widget.idMahasiswa, widget.mingguKp.toString());
  //   return _response;
  // }

  @override
  void initState() {
    super.initState();
    context
        .read<LogbookCubit>()
        .getDataLogbook(widget.idMahasiswa, widget.mingguKp.toString());
    context.read<MonitoringLogbookCubit>().getDataMonitoringLogbook(
        widget.idMahasiswa, widget.mingguKp.toString());
    context.read<GetMonitoringLogbookLuarCubit>().getDataMonitoringLogbookLuar(
        widget.idMahasiswa, widget.mingguKp.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 41, 107, 1),
        title: Text("Monitoring KP"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.15,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                    side: BorderSide(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Mahasiswa",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Nama",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                widget.namaMahasiswa,
                                style: TextStyle(fontSize: 14),
                              ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "NRP",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                widget.nrpMahasiswa,
                                style: TextStyle(fontSize: 14),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(25, 5, 10, 10),
                alignment: Alignment.topLeft,
                child: Text(
                  "Verifikasi Kegiatan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            BlocBuilder<LogbookCubit, LogbookState>(
              builder: (context, logbookState) {
                if (logbookState is LogbookProcessLoaded) {
                  return SpinKitRing(
                    color: Colors.black,
                  );
                } else if (logbookState is LogbookSuccessLoaded) {
                  return _widgetLogbook(context, logbookState.listLogbook);
                } else {
                  return Text('Data tidak ditemukan');
                }
              },
            ),
            Container(
                margin: EdgeInsets.fromLTRB(25, 10, 10, 10),
                alignment: Alignment.topLeft,
                child: Text(
                  "Catatan Pembimbing Kampus",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            BlocBuilder<MonitoringLogbookCubit, MonitoringLogbookState>(
              builder: (context, monitoringLogobokState) {
                if (monitoringLogobokState is MonitoringLogbookProcessLoaded) {
                  return SpinKitRing(color: Colors.black);
                } else if (monitoringLogobokState
                    is MonitoringLogbookSuccessLoaded) {
                  return Column(
                    children: [
                      Text(monitoringLogobokState
                          .dataMonitoringLogbook.namaPegawai),
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(8),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.black))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text((monitoringLogobokState
                                      .dataMonitoringLogbook.catatan !=
                                  null)
                              ? monitoringLogobokState
                                  .dataMonitoringLogbook.catatan
                              : "-"),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text("Tidak ada catatan");
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(25, 10, 10, 10),
                alignment: Alignment.topLeft,
                child: Text(
                  "Catatan Pembimbing Perusahaan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            BlocBuilder<GetMonitoringLogbookLuarCubit,
                GetMonitoringLogbookLuarState>(
              builder: (context, monitoringLogbookLuarState) {
                if (monitoringLogbookLuarState
                    is GetMonitoringLogbookLuarProcessLoaded) {
                  return SpinKitRing(
                    color: Colors.black,
                  );
                } else if (monitoringLogbookLuarState
                    is GetMonitoringLogbookLuarSuccessLoaded) {
                  return _widgetCatatan(context,
                      monitoringLogbookLuarState.dataMonitoringLogbookLuar);
                } else {
                  return Column(
                    children: <Widget>[
                      Text('Tidak ada catatan'),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      BlocListener<CheckboxCubit, CheckboxState>(
                        listener: (context, stateCheckbox) {
                          if (stateCheckbox is CheckboxChecked) {
                            setState(() {
                              setujuSubmit = true;
                            });
                          } else {
                            setState(() {
                              setujuSubmit = false;
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              BlocBuilder<CheckboxCubit, CheckboxState>(
                                builder: (context, state) {
                                  return Checkbox(
                                      value: setujuSubmit,
                                      onChanged: (value) {
                                        if (value == true) {
                                          this.setujuSubmit = value;
                                          context.read<CheckboxCubit>().check();
                                        } else {
                                          this.setujuSubmit = value;
                                          context
                                              .read<CheckboxCubit>()
                                              .uncheck();
                                        }
                                      });
                                },
                              ),
                              Flexible(
                                child: Text(
                                    "Dengan ini saya menyatakan telah memverifikasi\nkegiatan/materi mahasiswa KP yang bersangkutan."),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Text("Catatan/Saran")),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                maxLines: 4,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                controller: _controllerCatatan,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocConsumer<InsertMonitoringLogbookLuarCubit,
                          InsertMonitoringLogbookLuarState>(
                        listener: (context, stateMonitoringLogbookLuar) {
                          if (stateMonitoringLogbookLuar
                              is InsertMonitoringLogbookLuarFailSave) {
                            Fluttertoast.showToast(
                                msg: "Gagal verifikasi logbook",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 16.0);
                          } else if (stateMonitoringLogbookLuar
                              is InsertMonitoringLogbookLuarSuccessSave) {
                            Fluttertoast.showToast(
                                msg: "Berhasil verifikasi logobok",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 16.0);
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, monitoringLogbookLuarState) {
                          if (monitoringLogbookLuarState
                              is InsertMonitoringLogbookLuarProcessSave) {
                            return SpinKitRing(
                              color: Colors.black,
                            );
                          } else {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: EdgeInsets.all(15),
                              child: ButtonTheme(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      side: BorderSide(color: Colors.black)),
                                  child: RaisedButton(
                                    onPressed: (setujuSubmit)
                                        ? () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            final DateTime now = DateTime.now();
                                            final DateFormat formatter =
                                                DateFormat('dd-MM-yyyy');
                                            final String dateFormatted =
                                                formatter.format(now);

                                            if (setujuSubmit) {
                                              context
                                                  .read<
                                                      InsertMonitoringLogbookLuarCubit>()
                                                  .insertDataMonitoring(
                                                      prefs.getString(
                                                          "idKpDaftar"),
                                                      widget.mingguKp
                                                          .toString(),
                                                      now.month.toString(),
                                                      now.year.toString(),
                                                      _controllerCatatan.text,
                                                      dateFormatted,
                                                      widget.idMahasiswa,
                                                      prefs.getString(
                                                          "namaPembimbing"),
                                                      prefs.getString(
                                                          "nipPembimbing"));
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Mohon centang verifikasi.",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  fontSize: 16.0);
                                            }
                                          }
                                        : null,
                                    color: Color.fromRGBO(253, 184, 51, 1),
                                    child: Text("Submit"),
                                  )),
                            );
                          }
                        },
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetLogbook(BuildContext context, List<LogbookModel> data) {
    return Container(
      child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data[index].tanggal),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(data[index].jamMulai),
                            Text("s/d"),
                            Text(data[index].jamSelesai)
                          ],
                        ),
                        Row(
                          children: [
                            Text("Kegiatan : "),
                          ],
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.all(5),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.black))),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(data[index].kegiatan),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     ButtonTheme(
                        //         height: 35,
                        //         minWidth: 120.0,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(7),
                        //             side: BorderSide(color: Colors.black)),
                        //         child: RaisedButton(
                        //           onPressed: () {},
                        //           color: Color.fromRGBO(253, 184, 51, 1),
                        //           child: Text("File Progres"),
                        //         )),
                        //     ButtonTheme(
                        //         height: 35,
                        //         minWidth: 120.0,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(7),
                        //             side: BorderSide(color: Colors.black)),
                        //         child: RaisedButton(
                        //           onPressed: () {},
                        //           color: Color.fromRGBO(253, 184, 51, 1),
                        //           child: Text("File Foto"),
                        //         )),
                        //   ],
                        // )
                        Center(
                            child: Column(
                          children: [
                            Text("File Laporan"),
                            (data[index].fileProgresLaporan == "1")
                                ? ButtonTheme(
                                    height: 35,
                                    minWidth: 120.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        side: BorderSide(color: Colors.black)),
                                    child: RaisedButton(
                                      onPressed: () async {
                                        // String decoded = utf8.decode(base64.decode(data[index].dataFileProgresLaporan.replaceAll("\n", "")));
                                        var compressedString = base64.decode(
                                            data[index]
                                                .dataFileProgresLaporan
                                                .replaceAll("\n", ""));
                                        var gzipBytes = GZipCodec()
                                            .decode(compressedString);

                                        final output =
                                            await getTemporaryDirectory();
                                        final file =
                                            File("${output.path}/laporan.pdf");
                                        await file.writeAsBytes(gzipBytes);

                                        print("${output.path}/laporan.pdf");
                                        await OpenFile.open(
                                            "${output.path}/laporan.pdf");
                                        setState(() {});
                                      },
                                      color: Color.fromRGBO(253, 184, 51, 1),
                                      child: Text("File Laporan"),
                                    ))
                                : Text("-")
                          ],
                        )),
                      ]),
                ),
              ),
            );
          }),
    );
  }

  Widget _widgetCatatan(BuildContext context, MonitoringLogbookLuarModel data) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(8),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.black))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data.tanggalVerifikasi),
                Divider(
                  color: Colors.black,
                )
              ],
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.all(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text((data.catatan != null) ? data.catatan : "-"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonTheme(
                    height: 35,
                    minWidth: 120.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(color: Colors.black)),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Editcatatan(
                            idMonitoring: data.nomor,
                            idMahasiswa: widget.idMahasiswa,
                            nrpMahasiswa: widget.nrpMahasiswa,
                            namaMahasiswa: widget.namaMahasiswa,
                            mingguKp: widget.mingguKp,
                          );
                        }));
                      },
                      color: Color.fromRGBO(253, 184, 51, 1),
                      child: Text("Edit"),
                    )),
                BlocConsumer<DeleteMonitoringLogbookLuarCubit,
                    DeleteMonitoringLogbookLuarState>(
                  listener: (context, deleteMonitoringLogbookLuarState) {
                    if (deleteMonitoringLogbookLuarState
                        is DeleteMonitoringLogbookLuarFail) {
                      Fluttertoast.showToast(msg: "Gagal menghapus data");
                    } else if (deleteMonitoringLogbookLuarState
                        is DeleteMonitoringLogbookLuarSuccess) {
                      Fluttertoast.showToast(msg: "Sukses menghapus data");
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, deleteMonitoringLogbookLuarState) {
                    if (deleteMonitoringLogbookLuarState
                        is DeleteMonitoringLogbookLuarProcess) {
                      return SpinKitCircle(
                        color: Colors.black,
                      );
                    }

                    return ButtonTheme(
                        height: 35,
                        minWidth: 120.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: BorderSide(color: Colors.black)),
                        child: RaisedButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.WARNING,
                              body: Center(
                                child: Text(
                                  'Hapus Catatan ?',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              title: 'This is Ignored',
                              desc: 'This is also Ignored',
                              useRootNavigator: true,
                              btnOkOnPress: () {
                                context
                                    .read<DeleteMonitoringLogbookLuarCubit>()
                                    .deleteCatatan(data.nomor);
                              },
                            )..show();
                          },
                          color: Color.fromRGBO(253, 184, 51, 1),
                          child: Text("Delete"),
                        ));
                  },
                ),
              ],
            )
          ],
        ));
  }
}


// Widget _getLogbook(BuildContext context) {
//   return Container(
//     height: MediaQuery.of(context).size.height * 0.7,
//     margin: EdgeInsets.all(15),
//     child: Card(
//       shape: RoundedRectangleBorder(
//           side: BorderSide(color: Colors.black),
//           borderRadius: BorderRadius.circular(7)),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Expanded(flex: 1, child: Text("No")),
//                 Flexible(
//                     flex: 2,
//                     child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                                 side: BorderSide(color: Colors.black))),
//                         child: Text("1")))
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(flex: 1, child: Text("Tanggal")),
//                 Expanded(
//                     flex: 2,
//                     child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                                 side: BorderSide(color: Colors.black))),
//                         child: Text("Jan, 10 2021")))
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(flex: 1, child: Text("Jam Mulai")),
//                 Expanded(
//                     flex: 2,
//                     child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                                 side: BorderSide(color: Colors.black))),
//                         child: Text("18:00")))
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(flex: 1, child: Text("Jam Selesai")),
//                 Expanded(
//                     flex: 2,
//                     child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                                 side: BorderSide(color: Colors.black))),
//                         child: Text("19:00")))
//               ],
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.15,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Expanded(
//                     flex: 1,
//                     child: Text("Kegiatan/\nMateri"),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       padding: EdgeInsets.all(3),
//                       decoration: ShapeDecoration(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               side: BorderSide(color: Colors.black))),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Text(
//                             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eu pellentesque nunc. Fusce eget neque in ligula tempus euismod. Nulla sem augue, fermentum quis nulla in, luctus semper diam. Donec ut commodo massa. Aenean sollicitudin mi et orci hendrerit, quis pharetra arcu fermentum. Morbi tincidunt lacus leo, eu lacinia velit vulputate sit amet."),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(flex: 1, child: Text("Materi kuliah sesuai kegiatan")),
//                 Expanded(
//                     flex: 2,
//                     child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                                 side: BorderSide(color: Colors.black))),
//                         child: Text("-")))
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(flex: 1, child: Text("File Progres")),
//                 Flexible(
//                   flex: 2,
//                   child: ButtonTheme(
//                       height: 30,
//                       minWidth: 10,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(7),
//                           side: BorderSide(color: Colors.black)),
//                       child: RaisedButton(
//                         onPressed: () {},
//                         color: Color.fromRGBO(253, 184, 51, 1),
//                         child: Text("Lihat"),
//                       )),
//                 )
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(flex: 1, child: Text("File Foto")),
//                 Flexible(
//                   flex: 2,
//                   child: ButtonTheme(
//                       height: 30,
//                       minWidth: 10,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(7),
//                           side: BorderSide(color: Colors.black)),
//                       child: RaisedButton(
//                         onPressed: () {},
//                         color: Color.fromRGBO(253, 184, 51, 1),
//                         child: Text("Lihat"),
//                       )),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//   );

