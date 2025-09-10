import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/data/model/user_address.dart';
import 'package:watch_store/utils/response_validator.dart';

abstract class ICartDataSrc {
  Future<UserCart> getUserCart();
  Future<UserCart> addToCart({required int productId});
  Future<UserCart> deleteFromCart({required int productId});
  Future<UserCart> removeFromCart({required int productId});
  Future<UserAddress> getUserAddresses();
  Future<int> countCartItems();
  Future<String> payCart();
}

class CartRemoteDataSrc implements ICartDataSrc {
  final Dio httpClient;
  static const productIdJsonKey = 'product_id';
  CartRemoteDataSrc(this.httpClient);
  @override
  Future<UserCart> addToCart({required int productId}) async {
    final response = await httpClient.post(
      Endpoints.addToCart,
      data: {productIdJsonKey: productId},
    );

    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return UserCart.fromJson(response.data['data']);
  }

  @override
  Future<UserCart> deleteFromCart({required int productId}) async {
    final response = await httpClient.post(
      Endpoints.deleteFromCart,
      data: {productIdJsonKey: productId},
    );

    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return UserCart.fromJson(response.data['data']);
  }

  @override
  Future<UserCart> removeFromCart({required int productId}) async {
    final response = await httpClient.post(
      Endpoints.removeFromCart,
      data: {productIdJsonKey: productId},
    );

    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return UserCart.fromJson(response.data['data']);
  }

  @override
  Future<UserCart> getUserCart() async {
    final response = await httpClient.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return UserCart.fromJson(response.data['data']);
  }

  @override
  Future<int> countCartItems() async {
    final response = await httpClient.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return (response.data['data']['user_cart'] as List).length;
  }

  @override
  Future<String> payCart() async {
    final response = await httpClient.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return response.data['action'];
  }

  @override
  Future<UserAddress> getUserAddresses() async {
    final response = await httpClient.post(Endpoints.profile);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return UserAddress.fromJson(response.data['data']);
  }
}
