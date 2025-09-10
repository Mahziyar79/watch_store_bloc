import 'package:flutter/material.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/widgets/product_item.dart';
import 'package:watch_store/widgets/vertical_text.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.list,
    required this.onTap,
    required this.mainTitle,
  });
  final List<Product> list;
  final String mainTitle;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.medium),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        child: Row(
          children: [
            SizedBox(
              height: 320,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) {
                  return ProductItem(productItem: list[index]);
                },
              ),
            ),
            VerticalText(
              mainTitle: mainTitle,
              onTap: onTap,
              subTitle: AppStrings.viewAll,
            ),
          ],
        ),
      ),
    );
  }
}
