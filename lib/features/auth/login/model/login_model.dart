class LoginModel {
  String phone;
  String password;

  LoginModel({
    required this.phone,
    required this.password,
  });

  LoginModel copyWith({
    String? phone,
    String? password,
  }) {
    return LoginModel(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "phone": phone,
      "password": password,
    };
  }
}
