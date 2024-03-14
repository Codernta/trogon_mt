


import 'package:flutter/material.dart';
import 'package:trogon_mt/Utilities/Styles/text_styles.dart';

class ShowCastButton extends StatelessWidget {

  final VoidCallback onPress;
  const ShowCastButton({super.key,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue.shade900
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Show Cast',style: chatTitleForRatingStyle,),
      ),);
  }
}
