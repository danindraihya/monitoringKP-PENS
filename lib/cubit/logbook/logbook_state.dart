part of 'logbook_cubit.dart';

@immutable
abstract class LogbookState {}

class LogbookInitial extends LogbookState {}

class LogbookProcessLoaded extends LogbookState {}
class LogbookFailLoaded extends LogbookState {}
class LogbookSuccessLoaded extends LogbookState {
  final List<LogbookModel> listLogbook;

  LogbookSuccessLoaded(this.listLogbook);
}