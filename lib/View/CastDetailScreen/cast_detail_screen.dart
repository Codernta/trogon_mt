
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trogon_mt/Utilities/Styles/text_styles.dart';

class TvMazeCastPage extends StatefulWidget {
  final int showId;

  TvMazeCastPage({required this.showId});

  @override
  _TvMazeCastPageState createState() => _TvMazeCastPageState();
}

class _TvMazeCastPageState extends State<TvMazeCastPage> {
  late Future<List<dynamic>> _castFuture;

  @override
  void initState() {
    super.initState();
    _castFuture = fetchCast();
  }

  Future<List<dynamic>> fetchCast() async {
    final response =
    await http.get(Uri.parse('https://api.tvmaze.com/shows/${widget.showId}/cast'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cast');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cast',style: primaryStyle,),
      ),
      body: body()
    );
  }


  body(){
    return FutureBuilder(
    future: _castFuture,
    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: loader(),
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      } else {
        List<dynamic> cast = snapshot.data!;
        return ListView.builder(
          itemCount: cast.length,
          itemBuilder: (context, index) {
            final castMember = cast[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: castMember['person']['image'] != null
                    ? NetworkImage(castMember['person']['image']['medium'])
                    : null,
              ),
              title: Text(castMember['person']['name'],style: notSignedInStyle,),
              subtitle: Text('Role: ${castMember['character']['name']}',style: chatTitleStyle,),
            );
          },
        );
      }
    },
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