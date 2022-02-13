import 'package:dio/dio.dart';


abstract class HttpService {
  void init();
  Future<Response> getCountryPublishedAtListRequest() async {
    // TODO: implement GetHolidayRequest
    throw UnimplementedError();
  }
}