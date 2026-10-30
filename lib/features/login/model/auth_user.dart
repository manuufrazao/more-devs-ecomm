class LoginResponseModel {
  final UserModel user;
  final TokensModel tokens;

  LoginResponseModel({required this.user, required this.tokens});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user']),
      tokens: TokensModel.fromJson(json['tokens']),
    );
  }
}

class TokensModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  TokensModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    return TokensModel(
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
      expiresIn: json['expiresIn'],
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
