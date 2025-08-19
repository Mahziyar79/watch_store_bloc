import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/widgets/surface_container.dart';


class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    super.key,
    required this.count,
    required this.productTitle,
    required this.price,
    this.oldPrice = 0,
    this.discount = 0,
  });
  final int count;
  final String productTitle;
  final int price;
  final int oldPrice;
  final int discount;

  @override
  Widget build(BuildContext context) {
    return SurfaceContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  productTitle,
                  style: LightAppTextStyle.productTitle.copyWith(fontSize: 13),
                ),
                AppDimens.small.height,
                Text(
                  'قیمت : ${price.seperateWithComma} تومان',
                  style: LightAppTextStyle.productTitle.copyWith(fontSize: 14),
                ),
                AppDimens.small.height,
                Visibility(
                  visible: oldPrice > 0,
                  child: Text(
                    'قیمت با تخفیف : ${oldPrice.seperateWithComma} تومان',
                    style: LightAppTextStyle.productTitle.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                AppDimens.small.height,
                Divider(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svg.delete),
                    ),
                    Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svg.minus),
                    ),
                    Text(' $count عدد',style: LightAppTextStyle.title,),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svg.plus),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppDimens.small.width,
          Image.asset(Assets.png.unnamed.path, width: 80),
        ],
      ),
    );
  }
}
