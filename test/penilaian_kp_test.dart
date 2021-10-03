import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_kp_perusahaan/cubit/login/login_cubit.dart';
import 'package:monitoring_kp_perusahaan/cubit/penilaian_kp/get_data_nilai/get_data_nilai_cubit.dart';

void main() {
  group("Penilaian KP", () {

    blocTest("Get penilaian kp fail", build: () => GetDataNilaiCubit(), act: (cubit) => cubit.loadNilai(), expect: () => [isA<GetDataNilaiProcess>(), isA<GetDataNilaiFail>()]);

    blocTest("Login Success", build: () => LoginCubit(), act: (cubit) => cubit.login('1313567617'), expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()]);

    blocTest("Get penilaian kp sukses", build: () => GetDataNilaiCubit(), act: (cubit) => cubit.loadNilai(), expect: () => [isA<GetDataNilaiProcess>(), isA<GetDataNilaiSuccess>()]);

    

  });
}