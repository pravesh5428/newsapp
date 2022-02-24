import 'package:get/get.dart';
import 'package:newsapp/core/repository/news/newsList_repo_impl.dart';
import 'package:newsapp/feature/news/controller/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
    Get.put(NewsRepoImpl());
  }
}
