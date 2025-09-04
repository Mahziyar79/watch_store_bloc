import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/utils/response_validator.dart';

abstract class ICartDataSrc {
  Future<List<CartModel>> getUserCart();
  Future<List<CartModel>> addToCart({required int productId});
  Future<List<CartModel>> deleteFromCart({required int productId});
  Future<List<CartModel>> removeFromCart({required int productId});
  Future<int> countCartItems();
}

class CartRemoteDataSrc implements ICartDataSrc {
  final Dio httpClient;
  static const productIdJsonKey = 'product_id';
  CartRemoteDataSrc(this.httpClient);
  @override
  Future<List<CartModel>> addToCart({required int productId}) async {
    List<CartModel> cartList = <CartModel>[];
    final response = await httpClient.post(
      Endpoints.addToCart,
      data: {productIdJsonKey: productId},
    );

    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in (response.data['data']['user_cart'] as List)) {
      cartList.add(CartModel.fromJson(element));
    }
    return cartList;
  }

  @override
  Future<List<CartModel>> deleteFromCart({required int productId}) async {
    List<CartModel> cartList = <CartModel>[];
    final response = await httpClient.post(
      Endpoints.deleteFromCart,
      data: {productIdJsonKey: productId},
    );

    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in (response.data['data']['user_cart'] as List)) {
      cartList.add(CartModel.fromJson(element));
    }
    return cartList;
  }

  @override
  Future<List<CartModel>> removeFromCart({required int productId}) async {
    List<CartModel> cartList = <CartModel>[];
    final response = await httpClient.post(
      Endpoints.removeFromCart,
      data: {productIdJsonKey: productId},
    );

    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in (response.data['data']['user_cart'] as List)) {
      cartList.add(CartModel.fromJson(element));
    }
    return cartList;
  }

  @override
  Future<List<CartModel>> getUserCart() async {
    List<CartModel> cartList = <CartModel>[];
    final response = await httpClient.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in (response.data['data']['user_cart'] as List)) {
      cartList.add(CartModel.fromJson(element));
    }
    return cartList;
  }

  @override
  Future<int> countCartItems() async {
    final response = await httpClient.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return (response.data['data']['user_cart'] as List).length;
  }
}
