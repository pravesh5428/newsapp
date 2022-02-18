import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/core/model/news_response.dart';
import 'package:newsapp/core/model/sources_response.dart';
import 'package:newsapp/core/repository/news/newsList_repo.dart';
import 'package:newsapp/services/http_service.dart';
import 'package:newsapp/services/http_service_impl.dart';

class NewsRepoImpl implements NewsRepo {
  HttpService _httpService;

  NewsRepoImpl(){
    _httpService = Get.put(HttpServiceImpl());
    _httpService.init();
  }


  @override
  Future<NewsResponse> getNewsListDataAPI() async {
    try
    {
      final response = await _httpService.getNewsListDataRequest();
      Map<String, dynamic> responseMap = Map.from(jsonDecode(response.toString()));
      return NewsResponse.fromJson(responseMap);
    } on Exception catch (e) {
      debugPrint("Exception: "+e.toString());
      return null;
    }
  }

  @override
  Future<SourcesResponse> getSourcesAPI() async {
    try
    {
      final response = await _httpService.getSourcesRequest();
      Map<String, dynamic> responseMap = Map.from(jsonDecode(response.toString()));
      return SourcesResponse.fromJson(responseMap);
    } on Exception catch (e) {
      debugPrint("Exception: "+e.toString());
      return null;
    }
  }

}