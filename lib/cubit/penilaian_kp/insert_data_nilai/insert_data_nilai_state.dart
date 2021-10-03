part of 'insert_data_nilai_cubit.dart';

@immutable
abstract class InsertDataNilaiState {}

class InsertDataNilaiInitial extends InsertDataNilaiState {}
class InsertDataNilaiProcess extends InsertDataNilaiState {}
class InsertDataNilaiFail extends InsertDataNilaiState {}
class InsertDataNilaiSuccess extends InsertDataNilaiState {
  final double totalNilaiAkhir;



  InsertDataNilaiSuccess(this.totalNilaiAkhir);
}
