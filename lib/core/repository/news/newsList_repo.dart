import 'package:newsapp/core/model/news_response.dart';
import 'package:newsapp/core/model/sources_response.dart';

abstract class NewsRepo{
  Future<NewsResponse> getCountryPublishedAtListAPI();
  Future<SourcesResponse> getSourcesAPI();
}