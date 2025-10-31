part of 'base_bloc.dart';

@immutable
abstract class BaseEvent {}

class ShowLoadingEvent extends BaseEvent {
  final bool isRefresh;

  ShowLoadingEvent({this.isRefresh = false});
}

class DoneLoadingEvent extends BaseEvent {
  final bool isRefresh;

  DoneLoadingEvent({this.isRefresh = false});
}

class ErrorLoadingEvent extends BaseEvent {
  final bool isRefresh;
  final String? message;

  ErrorLoadingEvent({this.isRefresh = false, this.message});
}

class ShowMessageEvent extends BaseEvent {
  final String message;
  final bool isError;

  ShowMessageEvent({required this.message, this.isError = false});
}

class PaginationEvent extends BaseEvent {
  final bool isListNotEmpty;

  PaginationEvent({required this.isListNotEmpty});
}

class ReInitPaginationEvent extends BaseEvent {}
