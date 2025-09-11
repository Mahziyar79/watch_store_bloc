import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/extention.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/repo/home_repo.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/screens/home/bloc/home_bloc.dart';
import 'package:watch_store/screens/product_list/product_list_screen.dart';
import 'package:watch_store/widgets/app_slider.dart';
import 'package:watch_store/widgets/cat_widget.dart';
import 'package:watch_store/widgets/product_list.dart';
import 'package:watch_store/widgets/search_bar.dart';
import 'package:watch_store/widgets/search_bottom_sheet.dart';

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
                      MySearchBar(
                        onTap: () {
                          searchBottomSheet(context);
                        },
                      ),
                      AppSlider(imgList: state.home.sliders),
                      // Category
                      SizedBox(
                        height: 120,
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
                                    builder: (context) =>
                                        ProductListScreen.byCategory(
                                          categoryId:
                                              state.home.categories[index].id,
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      AppDimens.large.height,
                      ProductList(
                        mainTitle: AppStrings.newestProduct,
                        list: state.home.newestProducts,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductListScreen.sorted(
                                routeParam: ProductSortRoutes.newestProducts,
                              ),
                            ),
                          );
                        },
                      ),
                      ProductList(
                        list: state.home.mostSellerProducts,
                        mainTitle: AppStrings.topSells,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductListScreen.sorted(
                                routeParam:
                                    ProductSortRoutes.mostViewedProducts,
                              ),
                            ),
                          );
                        },
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
