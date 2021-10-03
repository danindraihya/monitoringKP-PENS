part of 'get_monitoring_logbook_luar_cubit.dart';

@immutable
abstract class GetMonitoringLogbookLuarState {}

class GetMonitoringLogbookLuarInitial extends GetMonitoringLogbookLuarState {}

class GetMonitoringLogbookLuarProcessLoaded extends GetMonitoringLogbookLuarState {}

class GetMonitoringLogbookLuarFailLoaded extends GetMonitoringLogbookLuarState {}

class GetMonitoringLogbookLuarSuccessLoaded extends GetMonitoringLogbookLuarState {
  final MonitoringLogbookLuarModel dataMonitoringLogbookLuar;

  GetMonitoringLogbookLuarSuccessLoaded(this.dataMonitoringLogbookLuar);
}