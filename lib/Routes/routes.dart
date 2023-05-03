
import 'package:demo/Pages/home.dart';
import 'package:demo/Pages/loading.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final appPages = [
    GetPage(name: Routes.loading, page: () => const LoadingPage()),
    GetPage(name: Routes.home, page: () => Home()),
  ];
}

class Routes {
  static const initial = home;
  static const loading = '/loading';
  static const home = '/home';
}