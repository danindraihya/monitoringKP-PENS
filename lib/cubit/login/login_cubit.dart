import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_kp_perusahaan/model/mahasiswa_model.dart';
import 'package:monitoring_kp_perusahaan/utilities/AppException.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  void login(String idKerjaPraktek) async {
    print('_response');
    emit(LoginLoadingState());
    try {
      final _response = await MahasiswaModel.connectApi(idKerjaPraktek);
      print(_response);
      if (_response is Exception) {
        emit(LoginFailureState(_response.toString()));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('idKerjaPraktek', idKerjaPraktek);
        print('sssssssssssss'); print(prefs.getString("idKerjaPraktek"));
        emit(LoginSuccessState());
      }
    } catch (error) {
      print(error);
    }
  }
}
