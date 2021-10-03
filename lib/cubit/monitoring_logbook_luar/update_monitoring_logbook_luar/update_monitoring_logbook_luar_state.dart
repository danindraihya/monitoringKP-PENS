part of 'update_monitoring_logbook_luar_cubit.dart';

@immutable
abstract class UpdateMonitoringLogbookLuarState {}

class UpdateMonitoringLogbookLuarInitial
    extends UpdateMonitoringLogbookLuarState {}

class UpdateMonitoringLogbookLuarProcess
    extends UpdateMonitoringLogbookLuarState {}

class UpdateMonitoringLogbookLuarFail extends UpdateMonitoringLogbookLuarState {
}

class UpdateMonitoringLogbookLuarSuccess
    extends UpdateMonitoringLogbookLuarState {}
