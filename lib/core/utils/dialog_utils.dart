import 'package:test_it_maha/presentation/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogsUtils {
  bool _isDialogLoadingShowing = false;
  bool _isGeneralDialogShowing = false;

  void showLoading() {
    if (!_isDialogLoadingShowing) {
      _isDialogLoadingShowing = true;
      Get.dialog(
        const LoadingDialog(),
        barrierDismissible: false,
      );
    }
  }

  void hideLoading() {
    if (_isDialogLoadingShowing) {
      _isDialogLoadingShowing = false;
      Get.back();
    }
  }

  void showGeneralDialog(Widget content) {
    if (!_isGeneralDialogShowing) {
      _isGeneralDialogShowing = true;
      Get.dialog(
        content,
        barrierDismissible: true,
      );
    }
  }

  void hideGeneralDialog() {
    if (_isGeneralDialogShowing) {
      _isGeneralDialogShowing = false;
      Get.back();
    }
  }
}
