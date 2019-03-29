import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {

  ErrorText(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {

    if (message != ''){

      return Align(
        
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.0,
              fontWeight: FontWeight.w600
            )
          ),
        )
      );
    }

    return Container();
  }
}