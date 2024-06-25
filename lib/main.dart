import 'dart:io';

import 'package:test_it_maha/core/utils/dialog_utils.dart';
import 'package:test_it_maha/presentation/config/navigation_routes/navigation.dart';
import 'package:test_it_maha/presentation/config/navigation_routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/config/http_overrides.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DialogsUtils(), permanent: true);

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (_, Widget? child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test IT Maha',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: Routes.USERS,
          getPages: Navigation.routes,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        ),
      );
  }
}
