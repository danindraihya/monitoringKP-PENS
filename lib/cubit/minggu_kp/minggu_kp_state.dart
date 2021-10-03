part of 'minggu_kp_cubit.dart';

@immutable
abstract class MingguKpState {}

class MingguKpInitial extends MingguKpState {}

class MingguKpProcessLoaded extends MingguKpState {}

class MingguKpFailLoaded extends MingguKpState {}

class MingguKpSuccessLoaded extends MingguKpState {}
