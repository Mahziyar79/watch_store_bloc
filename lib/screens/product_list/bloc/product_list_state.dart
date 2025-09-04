part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

final class ProductListLoadingState extends ProductListState {}

final class ProductListErrorState extends ProductListState {}

final class ProductListLoadedState extends ProductListState {
  final List<Product> productList;
  final List<Brand> brandList;

  const ProductListLoadedState({
    required this.productList,
    required this.brandList,
  });

  @override
  List<Object> get props => [productList, brandList];
}