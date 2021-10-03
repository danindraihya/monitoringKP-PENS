part of 'get_data_nilai_cubit.dart';

@immutable
abstract class GetDataNilaiState {}

class GetDataNilaiInitial extends GetDataNilaiState {}
class GetDataNilaiProcess extends GetDataNilaiState {}
class GetDataNilaiFail extends GetDataNilaiState {}
class GetDataNilaiSuccess extends GetDataNilaiState {
  final double totalNilaiAkhir;
  final String namaMahasiswa;
  final String nrpMahasiswa;

  GetDataNilaiSuccess({this.totalNilaiAkhir, this.namaMahasiswa, this.nrpMahasiswa});
}
