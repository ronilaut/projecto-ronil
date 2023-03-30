
import 'package:flutter/material.dart';
import 'package:intranet/constants.dart';
import 'side_bar_container.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SidebarContainer(
      title: "Categories",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Category(
            title: "Inteligencia Artifical",
            nimOfItems: 3,
            press: () {},
          ),
          Category(
            title: "Augmented reality",
            nimOfItems: 5,
            press: () {},
          ),
          Category(
            title: "Development",
            nimOfItems: 10,
            press: () {},
          ),
          Category(
            title: "Flutter UI",
            nimOfItems: 18,
            press: () {},
          ),
          Category(
            title: "Technology",
            nimOfItems: 12,
            press: () {},
          ),
          Category(
            title: "UI/UX Design",
            nimOfItems: 21,
            press: () {},
          ),
        ],
      ),
    );
  }
}


class Category extends StatelessWidget {
  final String title;
  final int nimOfItems;
  final VoidCallback press;
  const Category({
    Key? key,
    required this.title,
    required this.nimOfItems,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
      child: TextButton(
        onPressed: () {},
        child: Text.rich(
          TextSpan(
              text: title,
              style: const TextStyle(color: kDarkBlackColor),
              children: [
                TextSpan(
                  text: " ($nimOfItems)",
                  style: const TextStyle(color: kBodyTextColor),
                )
              ]),
        ),
      ),
    );
  }
}

