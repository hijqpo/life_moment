import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(

      type: MaterialType.transparency,
      //color: Colors.white,

      child: Center(
        child: Container(

          width: 180,
          height:150,
          color: Colors.white,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Loading...', 
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
                )
              ),
              
              Padding(padding: const EdgeInsets.symmetric(vertical: 10),),

              CircularProgressIndicator()
            ]
          ),
        ),
      )
    );
  }
}