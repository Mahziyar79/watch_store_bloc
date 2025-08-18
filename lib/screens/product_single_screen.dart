import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/cart_badge.dart';

class ProductSingleScreen extends StatelessWidget {
  const ProductSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          child: Row(
            children: [
              CartBadge(),
              Expanded(
                child: Text(
                  'نام محصول',
                  style: LightAppTextStyle.productTitle,
                  textDirection: TextDirection.rtl,
                ),
              ),
              IconButton(
                onPressed: () {},
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
                      child: Image.asset(
                        Assets.png.unnamed.path,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppDimens.medium),
                      margin: EdgeInsets.all(AppDimens.medium),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppDimens.medium),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('بنسر', style: LightAppTextStyle.title),
                          AppDimens.small.height,
                          Text(
                            'مسواک بنسر مدل آلفا با برس متوسط',
                            style: LightAppTextStyle.caption,
                          ),
                          AppDimens.small.height,
                          Divider(),
                          ProductTabView(),
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
                              '${10000.seperateWithComma} تومان',
                              style: LightAppTextStyle.title,
                            ),
                            Text(
                              200000.seperateWithComma,
                              style: LightAppTextStyle.oldPriceStyle,
                            ),
                          ],
                        ),
                        AppDimens.medium.width,
                        Container(
                          padding: EdgeInsets.all(AppDimens.small * .5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.red,
                          ),
                          child: Text('20%', style: LightAppTextStyle.tagTitle),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateColor.resolveWith((states) {
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
  }
}

class ProductTabView extends StatefulWidget {
  const ProductTabView({super.key});

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
          children: [Review(), Features(), Comments()],
        ),
      ],
    );
  }
}

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(' محصول خصوصیات');
  }
}

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(' نقد و بررسی ');
  }
}

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(' کامنت ');
  }
}
