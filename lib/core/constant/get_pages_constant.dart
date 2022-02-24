import 'package:get/get.dart';
import 'package:newsapp/core/constant/route_constant.dart';
import 'package:newsapp/feature/news/binding/news_binding.dart';
import 'package:newsapp/feature/news/view/news_view.dart';
import 'package:newsapp/feature/splash/view/splash.view.dart';

List<GetPage> getPages = [
  GetPage(
      name: RouteConstant.newsView,
      page: () => const NewsView(),
      binding: NewsBinding()),
  GetPage(
    name: RouteConstant.splashView,
    page: () => const SplashScreen(),
  ),
];
