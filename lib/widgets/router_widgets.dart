import 'package:flutter/material.dart';

class SlideDirection{

  static Offset get up {
    return Offset(0, 1);
  }

  static Offset get down {
    return Offset(0, -1);
  }

  static Offset get left {
    return Offset(-1, 0);
  }

  static Offset get right {
    return Offset(1, 0);
  }
}



class SlidePageRoute extends PageRouteBuilder{

  final Widget widget;
  final Offset offset;

  SlidePageRoute({this.widget, this.offset}) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return new SlideTransition(
        position: new Tween<Offset>(
          begin: offset,
          end: Offset.zero,
        ).animate(animation),
        child: widget,
      );
    }
  );
}