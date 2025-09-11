import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/screens/cart/bloc/cart_bloc.dart';
import 'package:watch_store/widgets/surface_container.dart';

class ShoppingCartItem extends StatefulWidget {
  const ShoppingCartItem({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    return SurfaceContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.cartModel.product,
                  style: LightAppTextStyle.productTitle.copyWith(fontSize: 13),
                  textAlign: TextAlign.right,
                ),
                AppDimens.small.height,
                Text(
                  'قیمت : ${widget.cartModel.price.seperateWithComma} تومان',
                  style: LightAppTextStyle.productTitle.copyWith(fontSize: 14),
                ),
                AppDimens.small.height,
                Visibility(
                  visible: widget.cartModel.discountPrice > 0,
                  child: Text(
                    'قیمت با تخفیف : ${widget.cartModel.discountPrice.seperateWithComma} تومان',
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
                      onPressed: () {
                        setState(() {
                          widget.cartModel.deleteLoading = true;
                        });
                        cartBloc.add(
                          DeleteFromCartEvent(widget.cartModel.productId),
                        );
                      },
                      icon: SvgPicture.asset(Assets.svg.delete),
                    ),
                    Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.cartModel.countLoading = true;
                        });
                        cartBloc.add(
                          RemoveFromCartEvent(widget.cartModel.productId),
                        );
                      },
                      icon: SvgPicture.asset(Assets.svg.minus),
                    ),
                    widget.cartModel.countLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            ' ${widget.cartModel.count} عدد',
                            style: LightAppTextStyle.title,
                          ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.cartModel.countLoading = true;
                        });
                        cartBloc.add(
                          AddToCartEvent(widget.cartModel.productId),
                        );
                      },
                      icon: SvgPicture.asset(Assets.svg.plus),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.cartModel.deleteLoading,
                  child: LinearProgressIndicator(),
                ),
              ],
            ),
          ),
          AppDimens.small.width,
          SizedBox(
            width: 80,
            child: Image.network(widget.cartModel.image, width: 80),
          ),
        ],
      ),
    );
  }
}
