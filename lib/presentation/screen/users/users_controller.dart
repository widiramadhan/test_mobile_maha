import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_it_maha/core/di/injection.dart';
import 'package:test_it_maha/core/state/view_state/view_state.dart';
import 'package:test_it_maha/core/utils/dialog_utils.dart';
import 'package:get/get.dart';
import 'package:test_it_maha/data/model/request/users_req.dart';
import 'package:test_it_maha/domain/entity/users/users_entity.dart';
import 'package:test_it_maha/domain/usecase/users_usecase.dart';

class UsersController extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final UsersUseCase _usersUseCase = inject<UsersUseCase>();
  final DialogsUtils _dialogsUtils = Get.find();

  Rx<ViewState<List<DataEntity>>> usersData = ViewState<List<DataEntity>>.initial().obs;

  final TextEditingController firstNameTEC = TextEditingController();
  final TextEditingController lastNameTEC = TextEditingController();
  final TextEditingController emailTEC = TextEditingController();

  final FocusNode firstNameFN = FocusNode();
  final FocusNode lastNameFN = FocusNode();
  final FocusNode emailFN = FocusNode();


  @override
  void onInit() async {
    super.onInit();
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getUsers() async {
    usersData.value = ViewState<List<DataEntity>>.loading();
    var result = await _usersUseCase.call();
    result.when(
      success: (data) {
        usersData.value = ViewState<List<DataEntity>>.success(data: data.data!);
      },
      error: (message, code, exception, stackTrace) async {
        usersData.value = ViewState<List<DataEntity>>.error(
            message: message);
      },
    );
  }

  void addUsers({
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    _dialogsUtils.showLoading();
    final result = await _usersUseCase.addUser(
        request: UsersReq(
            firstName: firstNameTEC.text,
            lastName: lastNameTEC.text,
            email: emailTEC.text,
        )
    );
    result.when(
      success: (data) {
        _dialogsUtils.hideLoading();
        onSuccess();
      },
      error: (message, code, exception, stackTrace) {
        _dialogsUtils.hideLoading();
        onError(message);
      },
    );
  }
}
