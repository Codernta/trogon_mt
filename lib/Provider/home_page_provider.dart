

import 'package:flutter/cupertino.dart';
import 'package:trogon_mt/Model/home_data_model.dart';
import 'package:trogon_mt/Services/home_page_services.dart';

class HomePageProvider with ChangeNotifier{
  HomePageModel? homePageModel;
bool loading = false;

Future getHomePageData({required BuildContext context,required List userData}) async {
  loading = true;
  homePageModel = await HomeScreenServices.getHomePageData(context: context);
  loading = false;
  print("|||||||||||||||||||| Home Page Details|||||||||||||||||");
  print(homePageModel);
  notifyListeners();
  return homePageModel;
}
}