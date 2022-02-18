import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/url_constant.dart';
import 'package:newsapp/services/http_service.dart';

class HttpServiceImpl implements HttpService {
  Dio _dio;

  @override
  void init() {
    _dio = Dio(BaseOptions(baseUrl: URLConstant.baseUrl));
  }


  @override
  Future<Response> getNewsListDataRequest() async {
    Response response;
    try {
      response = await _dio.get(URLConstant.topheadlines + 'country=in&sortBy=publishedAt&apiKey=ff322a77aa864d56b66a593d9042a4e5');
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> getSourcesRequest() async {
    Response response;
    try {
      response = await _dio.get(URLConstant.topHeadlinesSources+ 'apiKey=ff322a77aa864d56b66a593d9042a4e5');
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

}