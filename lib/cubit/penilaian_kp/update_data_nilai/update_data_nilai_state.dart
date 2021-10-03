part of 'update_data_nilai_cubit.dart';

@immutable
abstract class UpdateDataNilaiState {}

class UpdateDataNilaiInitial extends UpdateDataNilaiState {}
class UpdateDataNilaiProcess extends UpdateDataNilaiState {}
class UpdateDataNilaiFail extends UpdateDataNilaiState {}
class UpdateDataNilaiSuccess extends UpdateDataNilaiState {
  final double totalNilaiAkhir;



  UpdateDataNilaiSuccess(this.totalNilaiAkhir);
}