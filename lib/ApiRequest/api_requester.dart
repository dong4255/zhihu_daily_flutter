import 'package:dio/dio.dart';

import 'package:zhihu_daily_flutter/Constants/api_constants.dart';
import 'package:zhihu_daily_flutter/Model/news.dart';
import 'package:zhihu_daily_flutter/Model/news_detail.dart';

class ApiRequester {

  factory ApiRequester() => _getInstance();
  static ApiRequester get instance => _getInstance();
  static ApiRequester _instance;

  final _dio = Dio();

  ApiRequester._internal() {
    //初始化
    _dio.options.baseUrl = kBaseUrl;
  }

  static _getInstance() {
    if (_instance == null) {
      _instance = ApiRequester._internal();
    }

    return _instance;
  }


  Future<News> getLatestNews() async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.get(
          kLatestNewsUrl);
      print(response.data);
      return News.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<News> getBeforeNews(String date) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.get(kBeforeNewsUrl + date);
      print(response.data);
      return News.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<NewsDetail> getNewsDetail(int id) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.get(kNewsDetailUrl + '$id');
//      print(response.data);
      return NewsDetail.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }

}