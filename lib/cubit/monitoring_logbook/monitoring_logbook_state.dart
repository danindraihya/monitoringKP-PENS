part of 'monitoring_logbook_cubit.dart';

@immutable
abstract class MonitoringLogbookState {}

class MonitoringLogbookInitial extends MonitoringLogbookState {}

class MonitoringLogbookProcessLoaded extends MonitoringLogbookState {}
class MonitoringLogbookFailLoaded extends MonitoringLogbookState {}
class MonitoringLogbookSuccessLoaded extends MonitoringLogbookState {
  final MonitoringLogbookModel dataMonitoringLogbook;

  MonitoringLogbookSuccessLoaded(this.dataMonitoringLogbook);
}