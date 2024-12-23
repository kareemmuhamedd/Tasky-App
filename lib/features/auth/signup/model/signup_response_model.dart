class SignupResponseModel {
  final String id;
  final String displayName;
  final String access_token;
  final String refresh_token;

  SignupResponseModel({
    required this.id,
    required this.displayName,
    required this.access_token,
    required this.refresh_token,
  });

  SignupResponseModel copyWith({
    String? id,
    String? displayName,
    String? access_token,
    String? refresh_token,
  }) {
    return SignupResponseModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      access_token: access_token ?? this.access_token,
      refresh_token: refresh_token ?? this.refresh_token,
    );
  }

  factory SignupResponseModel.fromMap(Map<String, dynamic> map) {
    return SignupResponseModel(
      id: map['_id'] as String,
      displayName: map['displayName'] as String,
      access_token: map['access_token'] as String,
      refresh_token: map['refresh_token'] as String,
    );
  }
}
