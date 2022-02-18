import 'package:dio/dio.dart';


abstract class HttpService {
  void init();
  Future<Response> getNewsListDataRequest() async {
    throw UnimplementedError();
  }

  Future<Response> getSourcesRequest() async {
    throw UnimplementedError();
  }
}