import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/product_details.dart';
import 'package:watch_store/data/repo/product_repo.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/screens/product_single/bloc/product_single_bloc.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/cart_badge.dart';

class ProductSingleScreen extends StatelessWidget {
  const ProductSingleScreen({super.key, this.id = 0});
  final int id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) {
        final productSingleBloc = ProductSingleBloc(productRepository);
        productSingleBloc.add(ProductSingleInit(id: id));
        return productSingleBloc;
      },
      child: BlocBuilder<ProductSingleBloc, ProductSingleState>(
        builder: (context, state) {
          if (state is ProductSingleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductSingleLoaded) {
            return SafeArea(
              child: Scaffold(
                appBar: CustomAppBar(
                  child: Row(
                    children: [
                      CartBadge(),
                      Expanded(
                        child: Text(
                          state.productDetailes.title ?? "",
                          style: LightAppTextStyle.productTitle.copyWith(
                            fontSize: 14,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: SvgPicture.asset(Assets.svg.close),
                      ),
                    ],
                  ),
                ),
                body: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 60,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppDimens.medium.height,
                            SizedBox(
                              height: size.height / 3,
                              child: Image.network(
                                state.productDetailes.image ?? "",
                                fit: BoxFit.contain,
                                scale: 1,
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(AppDimens.medium),
                              margin: EdgeInsets.all(AppDimens.medium),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppDimens.medium,
                                ),
                                color: AppColors.mainBg,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    state.productDetailes.brand ?? "",
                                    style: LightAppTextStyle.title,
                                  ),
                                  AppDimens.small.height,
                                  Text(
                                    state.productDetailes.title ?? "",
                                    style: LightAppTextStyle.caption,
                                  ),
                                  AppDimens.small.height,
                                  Divider(),
                                  ProductTabView(
                                    productDetailes: state.productDetailes,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: AppDimens.medium,
                          right: AppDimens.medium,
                        ),
                        color: AppColors.appbar,
                        width: double.infinity,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${state.productDetailes.price!.seperateWithComma} تومان',
                                      style: LightAppTextStyle.title,
                                    ),
                                    Text(
                                      state
                                          .productDetailes
                                          .discountPrice!
                                          .seperateWithComma,
                                      style: LightAppTextStyle.oldPriceStyle,
                                    ),
                                  ],
                                ),
                                AppDimens.medium.width,
                                Container(
                                  padding: EdgeInsets.all(AppDimens.small * .5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: AppColors.discountBg,
                                  ),
                                  child: Text(
                                    '${state.productDetailes.discount}%',
                                    style: LightAppTextStyle.tagTitle,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: WidgetStateColor.resolveWith((
                                  states,
                                ) {
                                  return AppColors.primaryColor;
                                }),
                              ),
                              child: Text(
                                'افزودن به سبد خرید',
                                style: LightAppTextStyle.tagTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProductSingleError) {
            return Text('خطا');
          } else {
            return throw Exception('invalid State');
          }
        },
      ),
    );
  }
}

class ProductTabView extends StatefulWidget {
  final ProductDetailes productDetailes;
  const ProductTabView({super.key, required this.productDetailes});

  @override
  State<ProductTabView> createState() => _ProductTabViewState();
}

class _ProductTabViewState extends State<ProductTabView> {
  int selectedTabIndex = 0;
  List<String> tabs = ['نقد و بررسی', 'خصوصیات', 'نظرات'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ListView.builder(
            itemCount: tabs.length,
            scrollDirection: Axis.horizontal,
            itemExtent: MediaQuery.sizeOf(context).width * .28,
            reverse: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(AppDimens.medium),
                  child: Text(
                    tabs[index],
                    style: selectedTabIndex == index
                        ? LightAppTextStyle.selectedTab
                        : LightAppTextStyle.unSelectedTab,
                  ),
                ),
              );
            },
          ),
        ),
        IndexedStack(
          index: selectedTabIndex,
          children: [
            Review(text: widget.productDetailes.discussion!),
            PropertiesList(properties: widget.productDetailes.properties!),
            CommentList(comments: widget.productDetailes.comments!),
          ],
        ),
      ],
    );
  }
}

class PropertiesList extends StatelessWidget {
  final List<Properties> properties;
  const PropertiesList({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: properties.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppDimens.medium),
            margin: EdgeInsets.symmetric(vertical: 4),
            color: AppColors.surfaceColor,
            child: Text(
              "${properties[index].property} : ${properties[index].value}",
              style: LightAppTextStyle.caption,
              textAlign: TextAlign.right,
            ),
          );
        },
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  final List<Comments> comments;
  const CommentList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: comments.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppDimens.medium),
            margin: EdgeInsets.all(AppDimens.small),
            color: AppColors.surfaceColor,
            child: Text(
              "${comments[index].user} : ${comments[index].body}",
              style: LightAppTextStyle.caption,
              textAlign: TextAlign.right,
            ),
          );
        },
      ),
    );
  }
}

class Review extends StatelessWidget {
  const Review({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: LightAppTextStyle.title,
      textAlign: TextAlign.right,
    );
  }
}
