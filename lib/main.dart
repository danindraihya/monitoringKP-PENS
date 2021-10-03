import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monitoring_kp_perusahaan/cubit/checkbox/checkbox_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/data_kp/data_kp_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/edit_catatan/edit_catatan_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/logbook/logbook_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/login/login_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/minggu_kp/minggu_kp_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook/monitoring_logbook_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/delete_monitoring_logbook_luar/delete_monitoring_logbook_luar_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/get_monitoring_logbook_luar/get_monitoring_logbook_luar_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/insert_monitoring_logbook_luar/insert_monitoring_logbook_luar_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/penilaian_kp/get_data_nilai/get_data_nilai_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/penilaian_kp/insert_data_nilai/insert_data_nilai_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/penilaian_kp/update_data_nilai/update_data_nilai_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/set_profile/set_profile_cubit.dart';
import 'package:monitoring_kp_perusahaan/model/monitoring_model.dart';
import 'package:monitoring_kp_perusahaan/ui/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/monitoring_logbook_luar/update_monitoring_logbook_luar/update_monitoring_logbook_luar_cubit.dart';

// [Android-only] This "Headless Task" is run when the Android app
// is terminated with enableHeadless: true
///////////////////////////////////////////
// void backgroundFetchHeadlessTask(HeadlessTask task) async {
//   String taskId = task.taskId;
//   bool isTimeout = task.timeout;
//   if (isTimeout) {
//     // This task has exceeded its allowed running-time.
//     // You must stop what you're doing and immediately .finish(taskId)
//     print("[BackgroundFetch] Headless task timed-out: $taskId");
//     BackgroundFetch.finish(taskId);
//     return;
//   }

//   if (taskId == 'flutter_background_fetch') {
//     BackgroundFetch.scheduleTask(TaskConfig(
//         taskId: "Logbook Check",
//         delay: 15000,
//         periodic: true,
//         forceAlarmManager: true,
//         stopOnTerminate: false,
//         enableHeadless: true));
//   }

//   print('[BackgroundFetch] Headless event received.');
//   // Do your work here...
//   BackgroundFetch.finish(taskId);
// }

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {

//     LogbookModel.getListLogbook(idMahasiswa, minggu)

//     //simpleTask will be emitted here.
//     print('sssssssssssssssssssssssssss');
//     print(inputData['minggu']);

//     return Future.value(true);
//   });
// }

void main() {
  runApp(MyApp());
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => MingguKpCubit()),
        BlocProvider(create: (_) => CheckboxCubit()),
        BlocProvider(create: (_) => EditCatatanCubit()),
        BlocProvider(create: (_) => InsertMonitoringLogbookLuarCubit()),
        BlocProvider(create: (_) => DataKpCubit()),
        BlocProvider(create: (_) => GetMonitoringLogbookLuarCubit()),
        BlocProvider(create: (_) => MonitoringLogbookCubit()),
        BlocProvider(create: (_) => LogbookCubit()),
        BlocProvider(create: (_) => GetDataNilaiCubit()),
        BlocProvider(create: (_) => InsertDataNilaiCubit()),
        BlocProvider(create: (_) => SetProfileCubit()),
        BlocProvider(create: (_) => UpdateMonitoringLogbookLuarCubit()),
        BlocProvider(create: (_) => DeleteMonitoringLogbookLuarCubit()),
        BlocProvider(create: (_) => UpdateDataNilaiCubit())
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String idKerjaPraktek;
  MonitoringModel monitoringStatus;
  int idUser;

  bool loading = false;
  final TextEditingController controllerKey = TextEditingController();

  @override
  void initState() {
    getValidationData();
    super.initState();
    idUser = 1;
  }

  getValidationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idKerjaPraktek = prefs.getString("idKerjaPraktek");
    if (idKerjaPraktek != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Profile();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 41, 107, 1),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, loginState) {
            if (loginState is LoginLoadingState) {
              this.loading = true;
            } else if (loginState is LoginFailureState) {
              print('error');
            } else if (loginState is LoginSuccessState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/logo.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  margin: EdgeInsets.all(40),
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: BorderSide(color: Colors.black))),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Login", style: TextStyle(fontSize: 35)),
                        Row(
                          children: [
                            Text(
                              "Key",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Container(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: TextField(
                              maxLines: 1,
                              controller: controllerKey,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, loginState) {
                            if (loginState is LoginLoadingState) {
                              return SpinKitCircle(
                                color: Colors.black,
                              );
                            }
                            return ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side: BorderSide(color: Colors.black)),
                                child: RaisedButton(
                                  onPressed: () {
                                    context
                                        .read<LoginCubit>()
                                        .login(controllerKey.text);
                                  },
                                  color: Color.fromRGBO(253, 184, 51, 1),
                                  child: Text("Login"),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
