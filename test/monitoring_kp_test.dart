import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/get_monitoring_logbook_luar/get_monitoring_logbook_luar_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/monitoring_logbook_luar/insert_monitoring_logbook_luar/insert_monitoring_logbook_luar_cubit.dart';

void main() {
  group("Testing verifikasi logbook", () {
    blocTest("Get Verifikasi",
        build: () => GetMonitoringLogbookLuarCubit(),
        act: (cubit) => cubit.getDataMonitoringLogbookLuar("16135", "4"),
        expect: () => [
              isA<GetMonitoringLogbookLuarProcessLoaded>(),
              isA<GetMonitoringLogbookLuarSuccessLoaded>()
            ]);
    blocTest("Insert verifikasi",
        build: () => InsertMonitoringLogbookLuarCubit(),
        act: (cubit) => cubit.insertDataMonitoring("1758", "4", "2", "2000",
            "testing", "4-4-2020", "16135", "Christian", "21023012"),
        expect: () => [
              isA<InsertMonitoringLogbookLuarProcessSave>(),
              isA<InsertMonitoringLogbookLuarSuccessSave>()
            ]);
  });
}
