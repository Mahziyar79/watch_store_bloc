import 'package:watch_store/data/conf/remote_conf.dart';
import 'package:watch_store/data/model/user_address.dart';
import 'package:watch_store/data/model/user_info.dart';
import 'package:watch_store/data/src/user_data_src.dart';

abstract class IUserRepo {
  Future<User> getUserInfo();
  Future<UserAddress> getUserAddresses();
}

class UserRepository implements IUserRepo {
  final IUserDataSrc _dataSrc;

  UserRepository(this._dataSrc);

  @override
  Future<UserAddress> getUserAddresses() => _dataSrc.getUserAddresses();

  @override
  Future<User> getUserInfo() => _dataSrc.getUserInfo();

}

final userRepository = UserRepository(UserRemoteDataSrc(DioManager.dio));
