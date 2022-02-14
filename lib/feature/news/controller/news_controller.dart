import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/core/model/sources_response.dart' as sources;
import 'package:newsapp/core/model/news_response.dart';
import 'package:newsapp/core/repository/news/newsList_repo.dart';
import 'package:newsapp/core/repository/news/newsList_repo_impl.dart';

class NewsController extends GetxController{
  NewsRepo _newsRepo;
  NewsController(){
    _newsRepo= Get.find<NewsRepoImpl>();
  }

  RxString dropdownvalue = 'Newest'.obs;
  var items =  ['Popular','Newest','Oldest'];
  RxList<NewsResponse> newsResponse;
  RxList<Article> articlesResponse;
  RxList<sources.Source> sourceResponse;
  RxBool isLoading = false.obs;
  RxBool isSourceLoading = false.obs;

  @override
  void onInit() {
    getCountryPublishedAtData();
    getSourcesData();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getCountryPublishedAtData() async {
    isLoading.toggle();
    final response = await _newsRepo.getCountryPublishedAtListAPI();
    if(response!= null) {
      isLoading.toggle();
      articlesResponse = response.articles.obs;
    }
    else {
    List<NewsResponse> emptyList = List.empty(growable: true);
    newsResponse = emptyList;
    }
  }

  getSourcesData() async {
    isSourceLoading.toggle();
    final response = await _newsRepo.getSourcesAPI();
    if(response!=null) {
      isSourceLoading.toggle();
      sourceResponse = response.sources.obs;
      print("sourceResponse");
      print(isSourceLoading);
      print(sourceResponse[0].isChecked);
    } else {
        // else part
    }
  }

}