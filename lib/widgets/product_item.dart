import 'package:flutter/material.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productName,
    required this.image,
    required this.price,
    this.oldPrice = 0,
    this.discount = 0,
    this.time = 0,
  });
  final String productName;
  final String image;
  final int price;
  final int oldPrice;
  final int discount;
  final int time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.small),
      margin: EdgeInsets.all(AppDimens.medium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.productBgGradiant,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(AppDimens.medium),
      ),
      width: 200,
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: image.isEmpty
                ? Image.asset(Assets.png.unnamed.path)
                : Image.network(image, fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(productName, style: LightAppTextStyle.title),
          ),
          AppDimens.medium.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${price.seperateWithComma} تومان',
                    style: LightAppTextStyle.title,
                  ),
                  Visibility(
                    visible: oldPrice > 0,
                    child: Text(
                      oldPrice.seperateWithComma,
                      style: LightAppTextStyle.oldPriceStyle,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: discount > 0,
                child: Container(
                  padding: EdgeInsets.all(AppDimens.small * .5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.red,
                  ),
                  child: Text('$discount%', style: LightAppTextStyle.tagTitle),
                ),
              ),
            ],
          ),
          AppDimens.medium.height,
          Visibility(
            visible: time > 0,
            child: Container(
              height: 2,
              width: double.infinity,
              color: Colors.blue,
            ),
          ),
          AppDimens.medium.height,
          Visibility(
            visible: time > 0,
            child: Text(
              time.toString(),
              style: LightAppTextStyle.prodTimerStyle,
            ),
          ),
        ],
      ),
    );
  }
}
