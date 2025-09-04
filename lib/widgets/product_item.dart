import 'dart:async';
import 'package:flutter/material.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/screens/product_single/product_single_screen.dart';
import 'package:watch_store/utils/format_time.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.productItem});

  final Product productItem;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();

    if (widget.productItem.specialExpiration.isNotEmpty) {
      final expiry = DateTime.tryParse(widget.productItem.specialExpiration);
      if (expiry != null) {
        final diff = expiry.difference(DateTime.now());
        if (!diff.isNegative) {
          _remainingSeconds = diff.inSeconds;
          _startTimer();
        }
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final showTimer = _remainingSeconds > 0;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductSingleScreen(id: widget.productItem.id),
        ),
      ),
      child: Container(
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
              child: widget.productItem.image.isEmpty
                  ? Image.asset(Assets.png.unnamed.path)
                  : Image.network(widget.productItem.image, fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.productItem.title,
                style: LightAppTextStyle.title,
                textAlign: TextAlign.right,
              ),
            ),
            AppDimens.medium.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.productItem.price.seperateWithComma} تومان',
                      style: LightAppTextStyle.title,
                    ),
                    if (widget.productItem.discountPrice > 0)
                      Text(
                        widget.productItem.discountPrice.seperateWithComma,
                        style: LightAppTextStyle.oldPriceStyle,
                      ),
                  ],
                ),
                if (widget.productItem.discount > 0)
                  Container(
                    padding: EdgeInsets.all(AppDimens.small * .5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.red,
                    ),
                    child: Text(
                      '${widget.productItem.discount}%',
                      style: LightAppTextStyle.tagTitle,
                    ),
                  ),
              ],
            ),
            AppDimens.medium.height,
            if (showTimer) ...[
              Container(height: 2, width: double.infinity, color: Colors.blue),
              AppDimens.medium.height,
              Text(
                formatTime(_remainingSeconds),
                style: LightAppTextStyle.prodTimerStyle,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
