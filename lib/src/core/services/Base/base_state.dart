part of 'base_bloc.dart';

@immutable
abstract class BaseState {
  final RequestStatus status;
  final String? message;
  final bool isError;

  const BaseState({
    this.status = RequestStatus.initial,
    this.message,
    this.isError = false,
  });
}

class BaseInitial extends BaseState {
  const BaseInitial() : super(status: RequestStatus.initial);
}

class BaseLoading extends BaseState {
  final bool isRefresh;

  const BaseLoading({this.isRefresh = false})
      : super(status: RequestStatus.loading);
}

class BaseDone extends BaseState {
  const BaseDone() : super(status: RequestStatus.done);
}

class BaseError extends BaseState {
  const BaseError(String message)
      : super(
            status: RequestStatus.serverError, message: message, isError: true);
}

class BasePaginationLoading extends BaseState {
  const BasePaginationLoading() : super(status: RequestStatus.loading);
}
