import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/repo/product_repo.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/screens/product_list/bloc/product_list_bloc.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/cart_badge.dart';
import 'package:watch_store/widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  final param;
  const ProductListScreen({super.key, this.param});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final productListBloc = ProductListBloc(productRepository);
        productListBloc.add(ProductListInit(param: param));
        return productListBloc;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CartBadge(count: 1),
                Row(
                  children: [
                    Text('پرفروش ترین ها', style: LightAppTextStyle.title),
                    AppDimens.small.width,
                    SvgPicture.asset(Assets.svg.sort),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(Assets.svg.close),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              TagList(),
              BlocBuilder<ProductListBloc, ProductListState>(
                builder: (context, state) {
                  if (state is ProductListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductListLoaded) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: 0.58
                        ),
                        itemCount: state.productList.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                            productName: state.productList[index].title,
                            price: state.productList[index].price,
                            discount: state.productList[index].discount,
                            oldPrice: state.productList[index].discountPrice,
                            image: state.productList[index].image,
                            specialExpiration:
                                state.productList[index].specialExpiration,
                          );
                        },
                      ),
                    );
                  } else if (state is ProductListError) {
                    return Text('Error');
                  } else {
                    return throw Exception('invalid State');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagList extends StatelessWidget {
  const TagList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: AppDimens.medium),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          itemCount: 6,
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimens.small),
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.large,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(AppDimens.large),
              ),
              child: Text('نیوفورس', style: LightAppTextStyle.tagTitle),
            );
          },
        ),
      ),
    );
  }
}
