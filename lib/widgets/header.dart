import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Header extends StatelessWidget {
  final String title;

  Header({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Text(
            this.title,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24.0),
          ),
        ),
      ],
    );
  }
}
