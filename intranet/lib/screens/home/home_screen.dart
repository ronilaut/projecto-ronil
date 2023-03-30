// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intranet/constants.dart';
import 'package:intranet/models/blog.dart';
import 'package:intranet/screens/home/components/recent_post_card.dart';
import 'package:intranet/screens/home/components/side_bar_container.dart';
import 'components/blog_post_card.dart';
import 'components/categories.dart';
import 'components/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //BlogPostCard
        Expanded(
          flex: 2,
          child: Column(
            children: List.generate(
                blogPosts.length,
                (index) => BlogPostCard(
                      blog: blogPosts[index],
                    )),
          ),
        ),

        //Spacer
        const SizedBox(
          width: kDefaultPadding,
        ),

        //SideBar
        Expanded(
          child: Column(
            children: [
               const Search(),
               const SizedBox(height: kDefaultPadding),
              const Categories(),
              const SizedBox(height: kDefaultPadding,),
              SidebarContainer(
                title: "Recent Post",
                child: Column(
                  children: [
                    RecentPostCard(title: "Our ''Secret'' Formula to Online Workshops", image: "assets/images/recent_1.png", press: (){},),
                    const SizedBox(height: kDefaultPadding),
                    RecentPostCard(title: "Our ''Secret'' Formula to Online Workshops", image: "assets/images/recent_1.png", press: (){},),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
