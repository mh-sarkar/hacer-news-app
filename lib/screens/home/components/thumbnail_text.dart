import 'package:flutter/material.dart';

import '../../../constants.dart';

class ThumbnailText extends StatelessWidget {
  const ThumbnailText({
    Key key,
    @required this.author,
  }) : super(key: key);

  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: kDefaultPadding * .5),
      alignment: Alignment.center,
      width: kDefaultPadding * 2.5,
      height: kDefaultPadding * 2.5,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding * 1.25)),
      child: Text(
        author[0].toUpperCase(),
        style: TextStyle(
          fontFamily: "Aclonica-Regular",
          color: kBackgroundColor,
          fontSize: 36,
        ),
      ),
    );
  }
}
