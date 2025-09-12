import 'package:watch_store/data/model/address.dart';

class User {
  final UserInfo userInfo;
  final int userProcessingCount;
  final int userReceivedCount;
  final int userCancelCount;

  User({
    required this.userInfo,
    this.userProcessingCount = 0,
    this.userReceivedCount = 0,
    this.userCancelCount = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userInfo: UserInfo.fromJson(json['user_info'] ?? {}),
      userProcessingCount: json['user_processing_count'] ?? 0,
      userReceivedCount: json['user_received_count'] ?? 0,
      userCancelCount: json['user_cancel_count'] ?? 0,
    );
  }
}

class UserInfo {
  final int id;
  final String name;
  final String mobile;
  final String? phone;
  final Address? address;

  UserInfo({
    required this.id,
    this.name = "بدون نام",
    this.mobile = "-",
    this.phone,
    this.address,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? "بدون نام",
      mobile: json['mobile'] ?? "-",
      phone: json['phone'],
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
    );
  }
}
