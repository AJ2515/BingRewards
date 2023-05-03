import 'package:demo/Routes/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() async {
  await GetStorage.init();
  return runApp(DevicePreview(
    enabled: false, //!kReleaseMode,
    builder: (context) => Sizer(
      builder: ((context, orientation, deviceType) {
        return GetMaterialApp(
            title: "Bing Rewards",
            useInheritedMediaQuery: true,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.light, //globle.themedata,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.initial,
            getPages: AppRoutes.appPages);
      }),
    ),
  ));
}
