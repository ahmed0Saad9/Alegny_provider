import 'package:Alegny_provider/src/GeneralWidget/Widgets/SnackBar/custom_toast.dart';
import 'package:Alegny_provider/src/core/utils/request_status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'base_event.dart';
part 'base_state.dart';

abstract class BaseBloc<R> extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(BaseInitial()) {
    on<ShowLoadingEvent>(_onShowLoading);
    on<DoneLoadingEvent>(_onDoneLoading);
    on<ErrorLoadingEvent>(_onErrorLoading);
    on<ShowMessageEvent>(_onShowMessage);
    on<PaginationEvent>(_onPagination);
    on<ReInitPaginationEvent>(_onReInitPagination);
  }

  /// Repository instance (to be implemented by child classes)
  R get repository;

  /// Pagination state
  int _page = 1;
  int get page => _page;
  bool paginationLoading = false;

  /// Event handlers
  void _onShowLoading(ShowLoadingEvent event, Emitter<BaseState> emit) {
    if (event.isRefresh) {
      showEasyLoading();
    } else {
      emit(BaseLoading(isRefresh: event.isRefresh));
    }
  }

  void _onDoneLoading(DoneLoadingEvent event, Emitter<BaseState> emit) {
    if (event.isRefresh) {
      closeEasyLoading();
    } else {
      emit(BaseDone());
    }
  }

  void _onErrorLoading(ErrorLoadingEvent event, Emitter<BaseState> emit) {
    if (event.isRefresh) {
      closeEasyLoading();
      if (event.message != null) {
        errorEasyLoading(event.message!);
      }
    } else {
      emit(BaseError(event.message ?? 'An error occurred'));
    }
  }

  void _onShowMessage(ShowMessageEvent event, Emitter<BaseState> emit) {
    showMessage(event.message, isError: event.isError);
  }

  void _onPagination(PaginationEvent event, Emitter<BaseState> emit) {
    incrementPageNumber(event.isListNotEmpty);
  }

  void _onReInitPagination(
      ReInitPaginationEvent event, Emitter<BaseState> emit) {
    reInitPagination();
  }

  /// Loading methods (same as your GetX controller)
  void showLoading({bool isRefresh = false}) {
    add(ShowLoadingEvent(isRefresh: isRefresh));
  }

  void doneLoading({bool isRefresh = false}) {
    add(DoneLoadingEvent(isRefresh: isRefresh));
  }

  void errorLoading({bool isRefresh = false, String? message}) {
    add(ErrorLoadingEvent(isRefresh: isRefresh, message: message));
  }

  void showMessage(String message, {bool isError = false}) {
    add(ShowMessageEvent(message: message, isError: isError));
  }

  void incrementPageNumber(bool isListNotEmpty) {
    add(PaginationEvent(isListNotEmpty: isListNotEmpty));
  }

  void reInitPagination() {
    add(ReInitPaginationEvent());
  }

  /// EasyLoading wrappers
  void showEasyLoading() {
    EasyLoading.show();
  }

  void successEasyLoading(String message) {
    closeEasyLoading();
    showToast(message, isError: false);
  }

  void errorEasyLoading(String message) {
    closeEasyLoading();
    showToast(message, isError: true);
  }

  void closeEasyLoading() {
    EasyLoading.dismiss();
  }

  /// Utility method for network calls
  Future<void> handleNetworkCall<T>(
    Future<T> Function() networkCall, {
    bool showLoading = true,
    bool isRefresh = false,
    Function(T)? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      if (showLoading) {
        this.showLoading(isRefresh: isRefresh);
      }

      final result = await networkCall();

      if (showLoading) {
        doneLoading(isRefresh: isRefresh);
      }

      if (onSuccess != null) onSuccess(result);
    } catch (error) {
      final errorMessage = _handleError(error);

      if (showLoading) {
        errorLoading(isRefresh: isRefresh, message: errorMessage);
      }

      if (onError != null) onError(errorMessage);
    }
  }

  String _handleError(dynamic error) {
    // Handle different error types here
    return error.toString();
  }

  @override
  Future<void> close() {
    // Clean up resources
    return super.close();
  }
}
