
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trogon_mt/Utilities/Styles/text_styles.dart';
import 'package:trogon_mt/Utilities/Widgets/show_cast_button.dart';
import 'package:trogon_mt/View/CastDetailScreen/cast_detail_screen.dart';

class TvMazeMovieDetailPage extends StatefulWidget {
  final int showId;

  TvMazeMovieDetailPage({required this.showId});

  @override
  _TvMazeMovieDetailPageState createState() => _TvMazeMovieDetailPageState();
}

class _TvMazeMovieDetailPageState extends State<TvMazeMovieDetailPage> {
  late Future<Map<String, dynamic>> _movieDetailFuture;

  @override
  void initState() {
    super.initState();
    _movieDetailFuture = fetchMovieDetails(widget.showId);
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int showId) async {
    final response =
    await http.get(Uri.parse('https://api.tvmaze.com/shows/$showId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Show Details',style: primaryStyle,),
      ),
      body: body()
    );
  }

  body() {
    var size= MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
       height: size.height,
        width: size.width,
        child: FutureBuilder(
          future: _movieDetailFuture,
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(
                child:loader(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final Map<String, dynamic> movieDetails = snapshot.data!;
              return Stack(
                children: [
                  Positioned(
                      right: 20,
                      top: 60,
                      child:ShowCastButton(onPress: ()=> Get.to(()=> TvMazeCastPage(showId: widget.showId,)),)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          movieDetails['image']['original'],
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        movieDetails['name'],
                        style: primaryStyle,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Type: ${movieDetails['type']}',
                        style: notSignedInStyle,
                      ),
                      Text(
                        'Language: ${movieDetails['language']}',
                        style: notSignedInStyle,
                      ),
                      Text(
                        'Genres: ${movieDetails['genres'].join(', ')}',
                        style: notSignedInStyle,),
                      Text(
                        'Runtime: ${movieDetails['runtime']} minutes',
                        style: notSignedInStyle,
                      ),
                      Text(
                        'Premiered: ${movieDetails['premiered']}',
                        style: notSignedInStyle,
                      ),

                      Text(
                        'Rating: ${movieDetails['rating']['average']}',
                        style: notSignedInStyle,),
                      Text(
                        'Weight: ${movieDetails['weight']}',
                        style: notSignedInStyle,),
                      Text(
                        'Network Name: ${movieDetails['network']['name']}',
                        style: notSignedInStyle,),

                      Text(
                        'Official WebSite: ${movieDetails['officialSite']}',
                        style: notSignedInStyle,),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  loader() {
    return Center(
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.black12,
        child: CircularProgressIndicator(
          color: Colors.blue.shade900,
        ),
      ),
    );
  }
}