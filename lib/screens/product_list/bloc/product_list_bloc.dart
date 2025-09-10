import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/data/model/brand.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/data/repo/product_repo.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductReop _iProductReop;
  ProductListBloc(this._iProductReop) : super(ProductListLoadingState()) {
    on<ProductListEvent>((event, emit) async {
      try {
        if (event is ProductCategoryListEvent) {
          // ProductCategoryListEvent
          emit(ProductListLoadingState());
          final productList = await _iProductReop.getAllByCategory(event.param);
          final brandsList = await _iProductReop.getAllBrands();

          emit(
            ProductListLoadedState(
              brandList: brandsList,
              productList: productList,
            ),
          );
        } else if (event is ProductSortedListEvent) {
          // ProductSortedListEvent
          emit(ProductListLoadingState());
          final productList = await _iProductReop.getSorted(event.routeParam);
          final brandsList = await _iProductReop.getAllBrands();

          emit(
            ProductListLoadedState(
              brandList: brandsList,
              productList: productList,
            ),
          );
        } else if (event is ProductBrandListEvent) {
          // ProductBrandListEvent
          emit(ProductListLoadingState());
          final productList = await _iProductReop.getAllByBrand(event.id);
          final brandsList = await _iProductReop.getAllBrands();

          emit(
            ProductListLoadedState(
              brandList: brandsList,
              productList: productList,
            ),
          );
        } else if (event is ProductSearchListEvent) {
          // ProductSearchListEvent
          emit(ProductListLoadingState());
          final productList = await _iProductReop.searchProducts(
            event.searchKey,
          );
          debugPrint(productList.toString());
          final brandsList = await _iProductReop.getAllBrands();

          emit(
            ProductListLoadedState(
              brandList: brandsList,
              productList: productList,
            ),
          );
        }
      } catch (e) {
        emit(ProductListErrorState());
      }
    });
  }
}
