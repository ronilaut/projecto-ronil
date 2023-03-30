import 'package:flutter/material.dart';
import 'package:intranet/constants.dart';
import 'package:intranet/screens/home/home_screen.dart';

import 'components/header.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                constraints: const BoxConstraints(
                  maxWidth: kMaxWidth,
                ),
                child: const HomeScreen(),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
