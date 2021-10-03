part of 'checkbox_cubit.dart';

@immutable
abstract class CheckboxState {}

class CheckboxUnchecked extends CheckboxState {}

class CheckboxChecked extends CheckboxState {}