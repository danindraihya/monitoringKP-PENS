import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'checkbox_state.dart';

class CheckboxCubit extends Cubit<CheckboxState> {
  CheckboxCubit() : super(CheckboxUnchecked());

  void check() async {
    emit(CheckboxChecked());
  }

  void uncheck() async {
    emit(CheckboxUnchecked());
  }
}
