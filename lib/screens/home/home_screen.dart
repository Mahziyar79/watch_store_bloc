import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/data/repo/home_repo.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/screens/home/bloc/home_bloc.dart';
import 'package:watch_store/screens/product_list/product_list_screen.dart';
import 'package:watch_store/widgets/app_slider.dart';
import 'package:watch_store/widgets/cat_widget.dart';
import 'package:watch_store/widgets/product_item.dart';
import 'package:watch_store/widgets/search_bar.dart';
import 'package:watch_store/widgets/vertical_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(homeRepository);

        homeBloc.add(Homeinit());
        return homeBloc;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return SizedBox(
                    height: size.height - size.height * 0.2,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is HomeLoaded) {
                  return Column(
                    children: [
                      MySearchBar(onTap: () {}),
                      AppSlider(imgList: state.home.sliders),
                      // Category
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemCount: state.home.categories.length,
                          itemBuilder: (context, index) {
                            return CatWidget(
                              title: state.home.categories[index].title,
                              colors: index.isEven
                                  ? AppColors.catDesktopColors
                                  : AppColors.catDigitalColors,
                              iconPath: state.home.categories[index].image,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductListScreen(
                                      param: state.home.categories[index].id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      AppDimens.large.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.medium,
                        ),
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
                                  itemCount: state.home.amazingProducts.length,
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    return ProductItem(
                                      id: state.home.amazingProducts[index].id,
                                      image: state
                                          .home
                                          .amazingProducts[index]
                                          .image,
                                      productName: state
                                          .home
                                          .amazingProducts[index]
                                          .title,
                                      price: state
                                          .home
                                          .amazingProducts[index]
                                          .price,
                                      discount: state
                                          .home
                                          .amazingProducts[index]
                                          .discount,
                                      oldPrice: state
                                          .home
                                          .amazingProducts[index]
                                          .discountPrice,
                                      specialExpiration: state
                                          .home
                                          .amazingProducts[index]
                                          .specialExpiration,
                                    );
                                  },
                                ),
                              ),
                              VerticalText(
                                mainTitle: AppStrings.amazing,
                                onTap: () {},
                                subTitle: AppStrings.viewAll,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is HomeError) {
                  return const Text("error");
                } else {
                  throw Exception('invalid state');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
