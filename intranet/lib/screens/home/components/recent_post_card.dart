// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:intranet/constants.dart';

class RecentPostCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback press;
  const RecentPostCard({
    Key? key,
    required this.title,
    required this.image,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: press,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(image),
                ),
                const SizedBox(width: kDefaultPadding),
                 Expanded(
                  flex: 5,
                  child: Text(
                    title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontFamily: "Raleway",
                        color: kDarkBlackColor,
                        fontWeight: FontWeight.bold,
                        height: 1.5),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
