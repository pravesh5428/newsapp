import 'package:newsapp/core/model/news_response.dart';

abstract class NewsRepo{
  Future<NewsResponse> getCountryPublishedAtListAPI();
}