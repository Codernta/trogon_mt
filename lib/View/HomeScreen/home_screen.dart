


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trogon_mt/Utilities/Widgets/all_show_card_widget.dart';
import 'package:trogon_mt/Utilities/Widgets/appbar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:trogon_mt/View/MovieDetailScreen/movie_detail_screen.dart';


import '../../Utilities/Commons/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List<dynamic>> _showsFuture;


  @override
  void initState()  {
    super.initState();
  _showsFuture = fetchHomeData();
     // Provider.of<HomePageProvider>(context,listen: false).getHomePageData(context: context,);
  }


  Future<List<dynamic>> fetchHomeData() async {

    final response = await http.get(Uri.parse(Api.domainIp));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars,
      body: homePageBody(),
    );
  }

  homePageBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _showsFuture,
        builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return loader();
          }else{
            List<dynamic> shows = snapshot.data!;
            return Container(
              height: size.height,
              width: size.width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: shows.length,
                itemBuilder: (context, index) {
                  final show = shows[index];
                  return AllShowCard(
                    onPress: ()=> Get.to(()=> TvMazeMovieDetailPage(showId: show['id'])),
                    movieName: show["name"], imageUrl: show['image']['medium'], movieGenre: show['genres'].toString(), movieLanguage: show["language"], movieRating: show['rating']['average'].toString(),);
                },
              ),
            );
          }
        }
      ),
    );
  }



  loader() {
  return Center(
    child: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: Colors.blue.shade900,
        ),
      ),
    ),
  );
  }
}
