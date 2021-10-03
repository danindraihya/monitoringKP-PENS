import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_kp_perusahaan/cubit/login/login_cubit.dart';

void main() {
  group("Login", () {
    blocTest("Login Success", build: () => LoginCubit(), act: (cubit) => cubit.login('1313567617'), expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()]);
  });
}