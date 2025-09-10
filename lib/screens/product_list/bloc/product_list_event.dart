part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductCategoryListEvent extends ProductListEvent {
  final dynamic param;
  const ProductCategoryListEvent({required this.param});
  @override
  List<Object> get props => [param];
}

class ProductSortedListEvent extends ProductListEvent {
  final dynamic routeParam;
  const ProductSortedListEvent({required this.routeParam});
  @override
  List<Object> get props => [routeParam];
}

class ProductSearchListEvent extends ProductListEvent {
  final dynamic searchKey;
  const ProductSearchListEvent({required this.searchKey});
  @override
  List<Object> get props => [searchKey];
}

class ProductBrandListEvent extends ProductListEvent {
  final int id;
  const ProductBrandListEvent({required this.id});
  @override
  List<Object> get props => [id];
}
