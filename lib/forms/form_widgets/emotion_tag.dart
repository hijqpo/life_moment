import 'package:flutter/material.dart';

class EmotionTag extends StatelessWidget {

  EmotionTag(this.data);
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.all(4.0),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey[300],
      ),

      child: Text(
        '#$data',
      )

    );
  }
}