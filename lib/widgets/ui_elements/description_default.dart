import 'package:flutter/material.dart';

class DescriptionDefault extends StatelessWidget {
  final String title;

  DescriptionDefault(this.title);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.0),
      child: Text(title,
          softWrap: true,
          style: TextStyle(
              fontSize: deviceWidth > 700 ? 28.0 : 18.0,
              fontWeight: FontWeight.normal)),
    );
  }
}
