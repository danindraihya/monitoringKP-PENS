part of 'insert_monitoring_logbook_luar_cubit.dart';

@immutable
abstract class InsertMonitoringLogbookLuarState {}

class InsertMonitoringLogbookLuarInitial extends InsertMonitoringLogbookLuarState {}

class InsertMonitoringLogbookLuarProcessSave extends InsertMonitoringLogbookLuarState {}

class InsertMonitoringLogbookLuarFailSave extends InsertMonitoringLogbookLuarState {}

class InsertMonitoringLogbookLuarSuccessSave extends InsertMonitoringLogbookLuarState {}
