part of 'edit_catatan_cubit.dart';

@immutable
abstract class EditCatatanState {}

class EditCatatanProcessLoaded extends EditCatatanState {}
class EditCatatanFailLoaded extends EditCatatanState {}
class EditCatatanSuccessLoaded extends EditCatatanState {
  final MonitoringLogbookLuarModel data;

  EditCatatanSuccessLoaded(this.data);
}