import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  "https://api2.zoomg.ir/media/2023-1-link-click-anime-cover-66cc7d0f2b5676090d029d52?w=1080&q=80",
  "https://api2.zoomg.ir/media/10-movies-travel-68959104121d0ae8cadbd539?w=1080&q=80",
  "https://api2.zoomg.ir/media/2023-1-link-click-anime-cover-66cc7d0f2b5676090d029d52?w=1080&q=80",
  "https://api2.zoomg.ir/media/10-movies-travel-68959104121d0ae8cadbd539?w=1080&q=80",
];

class AppSlider extends StatefulWidget {
  const AppSlider({super.key, required this.imgList});
  final List<String> imgList;

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _controller,
            items: imgList.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(e, fit: BoxFit.cover),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((e) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.animateToPage(e.key);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: _current == e.key ? Colors.black : Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
