import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/screens/cart/bloc/cart_bloc.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/shopping_cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(CartInitEvent());
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(AppStrings.basket, style: LightAppTextStyle.title),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: AppDimens.medium),
              padding: EdgeInsets.all(AppDimens.medium),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(Assets.svg.leftArrow),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppStrings.sendToAddress,
                          style: LightAppTextStyle.caption,
                        ),
                        Text(
                          AppStrings.lorem,
                          style: LightAppTextStyle.caption,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoadedState) {
                  return CartList(list: state.userCart.cartList);
                } else if (state is CartItemAddedState) {
                  return CartList(list: state.userCart.cartList);
                } else if (state is CartItemDeletedState) {
                  return CartList(list: state.userCart.cartList);
                } else if (state is CartItemRemovedState) {
                  return CartList(list: state.userCart.cartList);
                } else if (state is CartErrorState) {
                  return Text('Error');
                } else if (state is CartLoadingState) {
                  return LinearProgressIndicator();
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            BlocConsumer<CartBloc, CartState>(
              listener: (context, state) async {
                if (state is RecivedPayLinkState) {
                  final Uri url = Uri.parse(state.url);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not Launch $url');
                  }
                }
              },
              builder: (context, state) {
                UserCart? userCart;
                switch (state.runtimeType) {
                  case const (CartLoadedState):
                  case const (CartItemAddedState):
                  case const (CartItemDeletedState):
                  case const (CartItemRemovedState):
                    userCart = (state as dynamic).userCart;
                    break;
                  case const (CartErrorState):
                    return Text('Error');
                  case const (CartLoadingState):
                    return LinearProgressIndicator();
                  default:
                    return SizedBox();
                }
                return Visibility(
                  visible: (userCart?.cartTotalPrice ?? 0) > 0,
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.medium,
                        vertical: AppDimens.small,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'مجموع ${userCart?.totalWithoutDiscountPrice.seperateWithComma} تومان',
                                style: LightAppTextStyle.title.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Visibility(
                                visible:
                                    userCart?.totalWithoutDiscountPrice !=
                                    userCart?.cartTotalPrice,
                                child: Text(
                                  'با تخفیف ${userCart?.cartTotalPrice.seperateWithComma} تومان',
                                  style: LightAppTextStyle.caption.copyWith(
                                    fontSize: 13,
                                    color: AppColors.discountBg,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<CartBloc>(
                                context,
                              ).add(PayEvent());
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateColor.resolveWith((
                                states,
                              ) {
                                return AppColors.primaryColor;
                              }),
                            ),
                            child: Text(
                              'ادامه فرآیند خرید',
                              style: LightAppTextStyle.tagTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({super.key, required this.list});
  final List<CartModel> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ShoppingCartItem(cartModel: list[index]);
        },
      ),
    );
  }
}
