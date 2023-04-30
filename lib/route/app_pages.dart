import 'package:flutter_chart_gpt/route/app_binding.dart';
import 'package:flutter_chart_gpt/screens/home/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: HomeScreen.route,
      page: () => const HomeScreen(),
      binding: AppBinding(),
    ),
  ];
}
