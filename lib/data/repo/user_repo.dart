import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:watch_store/data/conf/remote_conf.dart';
import 'package:watch_store/data/model/order.dart';
import 'package:watch_store/data/model/user_info.dart';
import 'package:watch_store/data/src/user_data_src.dart';

abstract class IUserRepo {
  Future<User> getUserInfo();
  Future<Address> getUserAddresses();
  Future<Order> userReceivedOrders();
  Future<Order> userCancelledOrders();
  Future<Order> userProcessingOrders();
}

class UserRepository implements IUserRepo {
  final IUserDataSrc _dataSrc;

  UserRepository(this._dataSrc);

  @override
  Future<Address> getUserAddresses() => _dataSrc.getUserAddresses();

  @override
  Future<User> getUserInfo() => _dataSrc.getUserInfo();

  @override
  Future<Order> userCancelledOrders() => _dataSrc.userCancelledOrders();

  @override
  Future<Order> userProcessingOrders() => _dataSrc.userProcessingOrders();

  @override
  Future<Order> userReceivedOrders() => _dataSrc.userReceivedOrders();
}

final userRepository = UserRepository(UserRemoteDataSrc(DioManager.dio));
