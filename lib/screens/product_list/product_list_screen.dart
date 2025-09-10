import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/brand.dart';
import 'package:watch_store/data/repo/cart_repo.dart';
import 'package:watch_store/data/repo/product_repo.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/screens/product_list/bloc/product_list_bloc.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/cart_badge.dart';
import 'package:watch_store/widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  final ProductListEvent initialEvent;

  const ProductListScreen._({required this.initialEvent});

  ProductListScreen({super.key})
    : initialEvent = ProductCategoryListEvent(param: null);

  factory ProductListScreen.byCategory({required dynamic categoryId}) {
    return ProductListScreen._(
      initialEvent: ProductCategoryListEvent(param: categoryId),
    );
  }

  factory ProductListScreen.sorted({required dynamic routeParam}) {
    return ProductListScreen._(
      initialEvent: ProductSortedListEvent(routeParam: routeParam),
    );
  }

  factory ProductListScreen.search({required dynamic searchKey}) {
    return ProductListScreen._(
      initialEvent: ProductSearchListEvent(searchKey: searchKey),
    );
  }

  factory ProductListScreen.brand({required int id}) {
    return ProductListScreen._(initialEvent: ProductBrandListEvent(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final productListBloc = ProductListBloc(productRepository);
        productListBloc.add(initialEvent);
        return productListBloc;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  builder: (context, value, child) {
                    return CartBadge(count: value);
                  },
                  valueListenable: cartRepository.cartCount,
                ),
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
          body: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductListLoadedState) {
                return Column(
                  children: [
                    TagList(tagList: state.brandList),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: 0.58,
                        ),
                        itemCount: state.productList.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                            productItem: state.productList[index],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is ProductListErrorState) {
                return Text('Error');
              } else {
                return throw Exception('invalid State');
              }
            },
          ),
        ),
      ),
    );
  }
}

class TagList extends StatelessWidget {
  const TagList({super.key, required this.tagList});
  final List<Brand> tagList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: AppDimens.medium),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          itemCount: tagList.length,
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.read<ProductListBloc>().add(
                  ProductBrandListEvent(id: tagList[index].id),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppDimens.small),
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.large,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(AppDimens.large),
                ),
                child: Text(
                  tagList[index].title,
                  style: LightAppTextStyle.tagTitle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
