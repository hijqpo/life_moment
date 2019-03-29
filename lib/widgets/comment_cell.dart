import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/utilities.dart';

class CommentCell extends StatelessWidget {

  CommentCell(this.data);
  final CommentData data;

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.symmetric(vertical: 4),
      color: Colors.blueGrey[100],
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data.avatarURL),
            ),

            title: Text(
              '${data.nickname}'
            ),

            subtitle: Text(
              '${displayTime(data.time)}'
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 16),
            child: Text(
              '${data.comment}'

            ),
          ),

          // Padding(padding: const EdgeInsets.all(12.0),)

        ],
      )

    );
  }}

