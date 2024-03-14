import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trogon_mt/Model/home_data_model.dart';
import 'package:trogon_mt/Utilities/Commons/api.dart';
import 'package:http/http.dart' as http;

class HomeScreenServices {
  static Future<HomePageModel?> getHomePageData(
      {required BuildContext context,}) async {
    HomePageModel? homePageModel;

    try {
      Response userData = await Dio().post(Api.domainIp);
      print('home page lists Info: ${userData.data}');
      if (userData.data['status']) {
        homePageModel = HomePageModel.fromJson(userData.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
        return homePageModel;
      }
      return homePageModel;
    }
    return homePageModel;
  }
}
