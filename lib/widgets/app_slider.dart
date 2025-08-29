import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/data/model/slide.dart';


class AppSlider extends StatefulWidget {
  const AppSlider({super.key, required this.imgList});
  final List<Slide> imgList;

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
            items: widget.imgList.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(e.image, fit: BoxFit.cover),
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
            children: widget.imgList.asMap().entries.map((e) {
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
