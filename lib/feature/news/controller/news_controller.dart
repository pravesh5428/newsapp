import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/core/model/sources_response.dart' as sources;
import 'package:newsapp/core/model/news_response.dart';
import 'package:newsapp/core/repository/news/newsList_repo.dart';
import 'package:newsapp/core/repository/news/newsList_repo_impl.dart';
import 'package:country_codes/country_codes.dart';

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

  RxInt index=3.obs;
  //RxInt id=1.obs;
  RxString title = "India".obs;
  RxString iso = "in".obs;
  RxString filterSources = "".obs;
  RxString bySort = "".obs;
  RxString q="".obs;
  RxString subUrl = "".obs;

  List<CountryList> countryList = [
    CountryList(
      id: 1,
      title: "Nepal",
      iso: "np"
    ),
    CountryList(
        id: 2,
        title: "USA",
        iso: "us"
    ),
    CountryList(
        id: 3,
        title: "India",
        iso: "in"
    ),
    CountryList(
        id: 4,
        title: "Sri lanka",
        iso: "lk"
    ),
    CountryList(
        id: 5,
        title: "England",
        iso: "gb"
    ),
    CountryList(
        id: 6,
        title: "Sweden",
        iso: "se"
    ),
    CountryList(
        id: 7,
        title: "UAE",
        iso: "se"
    ),
  ].obs;

  @override
  void onInit() {
    //CountryDetails details = CountryCodes.detailsForLocale();
    //iso.value = details.alpha2Code;
    //title.value = details.name;
    bySort.value = dropdownvalue.value;
    getNewsListData();
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


  getNewsListData() async {

    subUrl.value = 'country='+iso.value;

    if(bySort.value!=''){
      if(bySort.value=="Newest"){
        bySort.value = "publishedAt";
        subUrl.value+= '&sortBy='+bySort.value;
      } else if(bySort.value=="Popular"){
        bySort.value = "popularity";
        subUrl.value+= '&sortBy='+bySort.value;
      } else if(bySort.value=="Oldest"){
        bySort.value = "from=2022-02-18&to=2022-02-18";
        subUrl.value+= '&sortBy='+bySort.value;
      }
    }

    if(q.value!=''){
      q.value = q.value;
      subUrl.value+= '&q='+q.value;
    }

    if(filterSources.value!=''){
      filterSources.value = filterSources.value;
      subUrl.value+= '&sources='+q.value;
    }

    print("suburl"+subUrl.value);
    print("iso.value"+iso.value);
    print("bySort.value"+bySort.value);
    print("filterSources.value"+filterSources.value);
    print("q.value"+q.value);

    isLoading.toggle();
    final response = await _newsRepo.getNewsListDataAPI();
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

class CountryList {
  CountryList({
    this.id,
    this.key,
    this.title,
    this.iso
  });

  int id;
  Key key;
  String title;
  String iso;
}