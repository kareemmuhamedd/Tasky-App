class LoginResponseModel {
  final String id;
  final String access_token;
  final String refresh_token;

  LoginResponseModel({
    required this.id,
    required this.access_token,
    required this.refresh_token,
  });

  LoginResponseModel copyWith({
    String? id,
    String? access_token,
    String? refresh_token,
  }) {
    return LoginResponseModel(
      id: id ?? this.id,
      access_token: access_token ?? this.access_token,
      refresh_token: refresh_token ?? this.refresh_token,
    );
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      id: map['_id'] as String,
      access_token: map['access_token'] as String,
      refresh_token: map['refresh_token'] as String,
    );
  }
}
