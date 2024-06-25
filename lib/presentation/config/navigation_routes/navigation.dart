import 'package:get/get.dart';
import 'package:test_it_maha/presentation/config/navigation_routes/routes.dart';
import 'package:test_it_maha/presentation/screen/users/users_binding.dart';
import 'package:test_it_maha/presentation/screen/users/users_screen.dart';

class Navigation {
  Navigation._();

  static const INITIAL = Routes.USERS;
  static final routes = [
    GetPage(
      name: Routes.USERS,
      page: () => UsersScreen(),
      binding: UsersBinding(),
    ),
  ];
}
