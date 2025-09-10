class UserAddress {
  final int id;
  final String address;
  final String postalCode;
  final double lat;
  final double lng;
  final int userId;
  final String createdAt;
  final String updatedAt;

  UserAddress({
    required this.id,
    required this.address,
    required this.postalCode,
    required this.lat,
    required this.lng,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'] as int,
      address: json['address'] as String,
      postalCode: json['postal_code'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      userId: json['user_id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'postal_code': postalCode,
      'lat': lat,
      'lng': lng,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
