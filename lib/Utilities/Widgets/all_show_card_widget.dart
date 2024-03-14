

import 'package:flutter/material.dart';
import 'package:trogon_mt/Utilities/Styles/text_styles.dart';

class AllShowCard extends StatelessWidget {

  final String imageUrl;
  final String movieName;
  final String movieGenre;
  final String movieLanguage;
  final String movieRating;
  final VoidCallback onPress;

  AllShowCard({required this.movieName,required this.imageUrl,required this.movieGenre,required this.movieLanguage,required this.onPress,required this.movieRating});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Card(
        elevation: 5,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieName,
                          style: chatTitleStyle,
                        ),
                        Text('Genre: '+ movieGenre,style: chatSubTitleStyle, ),
                        Text('Language: '+ movieLanguage,style: chatSubTitleStyle,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                top: 5,
                right: 5,
                child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.star,color: Colors.yellow,)),
                      Expanded(
                        flex: 1,
                        child: Text(movieRating,style: chatTitleForRatingStyle,),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}