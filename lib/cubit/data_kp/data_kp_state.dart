part of 'data_kp_cubit.dart';

@immutable
abstract class DataKpState {}

class DataKpInitial extends DataKpState {}

class DataKpProcessLoaded extends DataKpState {}

class DataKpFailLoaded extends DataKpState {}

class DataKpSuccessLoaded extends DataKpState {
  final String namaPembimbingPerusahaan;
  final String nipPembimbingPerusahaan;
  final String jabatanPembimbingPerusahaan;

  DataKpSuccessLoaded({this.namaPembimbingPerusahaan, this.nipPembimbingPerusahaan, this.jabatanPembimbingPerusahaan});
}
