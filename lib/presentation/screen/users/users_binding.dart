import 'package:get/get.dart';
import 'package:test_it_maha/presentation/screen/users/users_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersController());
  }
}
