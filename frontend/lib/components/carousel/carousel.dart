import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<String> images = [
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
    "http://10.3.4.29:9292/uploads/COMUNICADO_NATAL_VERSAO_33254_a6224d4076.png",
  ];
  
  get imgList => null;
  
  get imageSliders => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
