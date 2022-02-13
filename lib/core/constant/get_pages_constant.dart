import 'package:get/get.dart';
import 'package:newsapp/core/constant/route_constant.dart';
import 'package:newsapp/feature/news/binding/news_binding.dart';
import 'package:newsapp/feature/news/view/news_view.dart';


List<GetPage> getPages = [
GetPage(
name: RouteConstant.newsView,
page: () => NewsView(),
binding: NewsBinding()),
];