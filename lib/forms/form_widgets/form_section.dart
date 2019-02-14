import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {

  FormSection({
    this.margin = const EdgeInsets.only(bottom: 12.0),
    this.padding = const EdgeInsets.all(12.0),

    @required this.children,
  });

  final EdgeInsets margin;
  final EdgeInsets padding;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: margin,
        padding: padding,

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[300]

        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        )

    );
  }
}