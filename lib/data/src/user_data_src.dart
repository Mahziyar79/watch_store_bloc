import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/order.dart';
import 'package:watch_store/data/model/user_address.dart';
import 'package:watch_store/data/model/user_info.dart';
import 'package:watch_store/utils/response_validator.dart';

abstract class IUserDataSrc {
  Future<User> getUserInfo();
  Future<UserAddress> getUserAddresses();
  Future<Order> userReceivedOrders();
  Future<Order> userCancelledOrders();
  Future<Order> userProcessingOrders();
}

class UserRemoteDataSrc implements IUserDataSrc {
  final Dio httpClient;

  UserRemoteDataSrc(this.httpClient);
  @override
  Future<UserAddress> getUserAddresses() async{
    final response = await httpClient.post(Endpoints.userAddresses);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return UserAddress.fromJson(response.data['data']);
  }

  @override
  Future<User> getUserInfo() async {
    final response = await httpClient.post(Endpoints.profile);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return User.fromJson(response.data['data']);
  }

  @override
  Future<Order> userCancelledOrders() {
    // TODO: implement userCancelledOrders
    throw UnimplementedError();
  }

  @override
  Future<Order> userProcessingOrders() {
    // TODO: implement userProcessingOrders
    throw UnimplementedError();
  }

  @override
  Future<Order> userReceivedOrders() {
    // TODO: implement userReceivedOrders
    throw UnimplementedError();
  }
}
