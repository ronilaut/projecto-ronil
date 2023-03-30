import 'package:flutter/material.dart';
import 'package:intranet/constants.dart';

import 'web_menu.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kPrimaryColor,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            constraints: const BoxConstraints(maxWidth: kMaxWidth),
            child: Row(
              children: [
                //Image.asset("assets/icons/RONIL75.png"),
                //SvgPicture.asset("assets/icons/RONIL75.png"),
                const Spacer(),
                WebMenu(),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          const Text(
            "Welcome To The Jungle",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Text(
              "Fique actualizado com as mais recentes notícias, desde notícias internas até as notícias do mundo inteiro. \nO Céu é o limite!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Raleway', height: 1.5),
            ),
          ),
          FittedBox(
            child: TextButton(
              onPressed: () {},
              child: Row(
                children: const [
                  Text(
                    "Ver Mais",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: kDefaultPadding,
          )
        ],
      )),
    );
  }
}
