import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimelineLikesPart extends StatelessWidget {
  const TimelineLikesPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.heart),
          onPressed: () => _unlikeIt(context),
        ),
        Text("{10}"),
      ],
    );
  }

  _unlikeIt(BuildContext context) async {}
}
