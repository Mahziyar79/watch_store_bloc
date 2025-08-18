import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:watch_store/gen/assets.gen.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key, this.count = 0});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 32, width: 32),
        SvgPicture.asset(
          Assets.svg.cart,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
        Visibility(
          visible: count > 0,
          child: Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
