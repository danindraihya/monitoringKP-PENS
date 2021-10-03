part of 'set_profile_cubit.dart';

@immutable
abstract class SetProfileState {}

class SetProfileInitial extends SetProfileState {}

class SetProfileProcess extends SetProfileState {}

class SetProfileFail extends SetProfileState {}

class SetProfileSuccess extends SetProfileState {}
