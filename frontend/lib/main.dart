import 'dart:async';

import 'package:flutter/material.dart';

import 'components/navbar/navigation_bar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final PageController controller = PageController();
  late Timer timer;

  List<String> images = [
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/disco_f65c5170fb.png",
    "http://10.3.4.29:9292/uploads/R1_b037a13134.png",
    "http://10.3.4.29:9292/uploads/image001_2ea32dc03e.jpg",
    "http://10.3.4.29:9292/uploads/R1_b037a13134.png",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentIndex < images.length) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      controller.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopMenuBar(),
            //const SizedBox(height: 5,),
            SizedBox(
              width: 1152,
              height: 450,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index % images.length;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 450,
                    width: 1152,
                    child: Image.network(
                      images[index % images.length],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width: 1152,
              child: Row(
                children: [
                  IconButton(
                        onPressed: () {
                          controller.animateToPage(currentIndex - 1,
                              duration: Duration(seconds: 3),
                              curve: Curves.slowMiddle);
                          //controller.jumpToPage(currentIndex - 1);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < images.length; i++)
                          buildIndicator(currentIndex == i)
                      ],
                    ),
                  ),
                  IconButton(
                        onPressed: () {
                          controller.animateToPage(currentIndex + 1,
                              duration: Duration(seconds: 3),
                              curve: Curves.slowMiddle);
                          //controller.jumpToPage(currentIndex + 1);
                        },
                        icon: const Icon(Icons.arrow_forward),
                      )
                ],
              ),
            ),
          ],
        ),
      ),
      //body: const TopMenuBar(),
    );
  }
}

Widget buildIndicator(bool isSelected) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 1),
    child: Container(
      height: isSelected ? 12 : 8,
      width: isSelected ? 12 : 8,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey),
    ),
  );
}
