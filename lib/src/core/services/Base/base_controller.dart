import 'package:Alegny_provider/src/GeneralWidget/Widgets/SnackBar/custom_toast.dart';
import 'package:Alegny_provider/src/core/utils/request_status.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

abstract class BaseController<R> extends GetxController {
  /// Loading
  RequestStatus status = RequestStatus.initial;

  void showLoading({bool isRefresh = false}) {
    if (isRefresh) {
      showEasyLoading();
    } else {
      status = RequestStatus.loading;
    }
  }

  void doneLoading({bool isRefresh = false}) {
    if (isRefresh) {
      if (isRefresh) closeEasyLoading();
    } else {
      status = RequestStatus.done;
    }
  }

  void errorLoading({bool isRefresh = false}) {
    status = RequestStatus.serverError;
    if (isRefresh) closeEasyLoading();
  }

  void showEasyLoading() {
    EasyLoading.show();
  }

  void successEasyLoading(String mes) {
    closeEasyLoading();
    showToast(mes, isError: false);
    // EasyLoading.showSuccess(mes, dismissOnTap: true);
  }

  void errorEasyLoading(String mes) {
    closeEasyLoading();
    showToast(mes, isError: true);

    // EasyLoading.showError(mes,dismissOnTap: true);
  }

  void closeEasyLoading() {
    EasyLoading.dismiss();
  }

  /// inject repo
  R? get repository;

  /// U need to inject a repo instance if not coming from a root , Bindings()

  // add all listeners to dispose them

  ///Matches on page creates
  @override
  void onInit() {
    super.onInit();
  }

  void showMessage(String message, {bool isError = false}) {
    showToast(message, isError: true);
  }

  /// Messages

  /// ForRepresentativeOnly Pagination
  int _page = 1;

  int get page => _page;

  void incrementPageNumber(bool isListNotEmpty) {
    if (isListNotEmpty) {
      _page++;
    }
  }

  bool paginationLoading = false;

  void reInitPagination() {
    _page = 1;
    paginationLoading = false;
  }
}
