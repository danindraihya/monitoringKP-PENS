import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monitoring_kp_perusahaan/cubit/data_kp/data_kp_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/minggu_kp/minggu_kp_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/set_profile/set_profile_cubit.dart';
import 'package:monitoring_kp_perusahaan/main.dart';
import 'package:monitoring_kp_perusahaan/ui/drawer.dart';
import 'package:monitoring_kp_perusahaan/ui/edit_profile_view.dart';
import 'package:monitoring_kp_perusahaan/ui/widgets/input_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController controllerNama = TextEditingController();
  final TextEditingController controllerNip = TextEditingController();
  final TextEditingController controllerJabatan = TextEditingController();

  FlutterLocalNotificationsPlugin notificationMonitoring =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    context.read<MingguKpCubit>().getDataMingguKp();
    context.read<DataKpCubit>().getDataKp();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    notificationMonitoring.initialize(initializationSettings);

    _getNotification();
  }

  _getNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        importance: Importance.max);
    var iOSDetails = new IOSNotificationDetails();

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await notificationMonitoring.showWeeklyAtDayAndTime(
        1,
        "Reminder",
        "Reminder Monitoring Logbook KP",
        Day.monday,
        Time(12, 0, 0),
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MingguKpCubit, MingguKpState>(
      listener: (context, mingguKpState) async {
        if (mingguKpState is MingguKpFailLoaded) {
          Fluttertoast.showToast(msg: "Data kerja praktek tidak ditemukan");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("idKerjaPraktek");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MyApp();
          }));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 41, 107, 1),
          title: Text("Profile"),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("idKerjaPraktek");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                })
          ],
        ),
        drawer: BaseDrawer(),
        body: BlocBuilder<DataKpCubit, DataKpState>(
          builder: (context, dataKpState) {
            if (dataKpState is DataKpSuccessLoaded) {
              return BlocConsumer<SetProfileCubit, SetProfileState>(
                listener: (context, setProfileState) {
                  if (setProfileState is SetProfileSuccess) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Profile();
                    }));
                  }
                },
                builder: (context, setProfileState) {
                  if (setProfileState is SetProfileProcess) {
                    return SpinKitCircle(
                      color: Colors.black,
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: EdgeInsets.all(5),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  (dataKpState.namaPembimbingPerusahaan == null)
                                      ? InputData(
                                          atribut: "Nama",
                                          controller: controllerNama,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          maxLines: 2,
                                        )
                                      : Row(
                                          children: [
                                            Expanded(child: Text('Nama')),
                                            Expanded(
                                              child: Text(dataKpState
                                                  .namaPembimbingPerusahaan),
                                            )
                                          ],
                                        ),
                                  (dataKpState.nipPembimbingPerusahaan == null)
                                      ? InputData(
                                          atribut: "NIP",
                                          controller: controllerNip,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          maxLines: 2,
                                        )
                                      : Row(
                                          children: [
                                            Expanded(child: Text('NIP')),
                                            Expanded(
                                                child: Text(dataKpState
                                                    .nipPembimbingPerusahaan))
                                          ],
                                        ),
                                  (dataKpState.jabatanPembimbingPerusahaan ==
                                          null)
                                      ? InputData(
                                          atribut: "Jabatan",
                                          controller: controllerJabatan,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          maxLines: 2,
                                        )
                                      : Row(
                                          children: [
                                            Expanded(child: Text("Jabatan")),
                                            Expanded(
                                                child: Text(dataKpState
                                                    .jabatanPembimbingPerusahaan))
                                          ],
                                        ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: ButtonTheme(
                                        height: 30,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            side: BorderSide(
                                                color: Colors.black)),
                                        child: RaisedButton(
                                          onPressed: () async {
                                            if (dataKpState
                                                    .namaPembimbingPerusahaan ==
                                                null) {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String namaPembimbing;
                                              String jabatanPembimbing;
                                              String nipPembimbing;

                                              if (controllerNama.text == "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Harap isi data profile");
                                              } else {
                                                namaPembimbing =
                                                    controllerNama.text;
                                                if (controllerJabatan.text ==
                                                    "") {
                                                  jabatanPembimbing = "-";
                                                } else {
                                                  jabatanPembimbing =
                                                      controllerJabatan.text;
                                                }
                                                if (controllerNip.text == "") {
                                                  nipPembimbing = "-";
                                                } else {
                                                  nipPembimbing =
                                                      controllerNip.text;
                                                }
                                                context
                                                    .read<SetProfileCubit>()
                                                    .setProfile(
                                                        namaPembimbing,
                                                        jabatanPembimbing,
                                                        nipPembimbing,
                                                        prefs.getString(
                                                            "idMahasiswa"));
                                              }
                                            } else {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return EditProfile(
                                                  namaPembimbing: dataKpState
                                                      .namaPembimbingPerusahaan,
                                                  nipPembimbing: dataKpState
                                                      .nipPembimbingPerusahaan,
                                                  jabatanPembimbing: dataKpState
                                                      .jabatanPembimbingPerusahaan,
                                                );
                                              }));
                                            }
                                          },
                                          color:
                                              Color.fromRGBO(253, 184, 51, 1),
                                          child: Text("Ubah"),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Catatan:",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              "Dimohon mengisi data profile sebelum melakukan monitoring dan penilaian kerja praktek."),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (dataKpState is DataKpProcessLoaded) {
              return SpinKitCircle(
                color: Colors.black,
              );
            } else {
              return Center(child: Text('Gagal mendapatkan data'));
            }
          },
        ),
      ),
    );
  }
}
