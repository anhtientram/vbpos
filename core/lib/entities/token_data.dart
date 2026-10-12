part of '../core.dart';

class TokenData {
  String? accessToken;
  int? expiresIn;
  String? idToken;
  String? refreshToken;
  String? secretKey;
  String? tokenType;
  String? mapToken;

  TokenData({
    this.accessToken,
    this.expiresIn,
    this.idToken,
    this.refreshToken,
    this.secretKey,
    this.tokenType,
    this.mapToken,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
    accessToken: json["accessToken"],
    expiresIn: json["expiresIn"],
    idToken: json["idToken"],
    refreshToken: json["refreshToken"],
    secretKey: json["secretKey"],
    tokenType: json["tokenType"],
    mapToken: json["mapToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "expiresIn": expiresIn,
    "idToken": idToken,
    "refreshToken": refreshToken,
    "secretKey": secretKey,
    "tokenType": tokenType,
    "mapToken": mapToken,
  };

  TokenData copyWith({
    String? accessToken,
    int? expiresIn,
    String? idToken,
    String? refreshToken,
    String? secretKey,
    String? tokenType,
    String? mapToken,
  }) {
    return TokenData(
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
      idToken: idToken ?? this.idToken,
      refreshToken: refreshToken ?? this.refreshToken,
      secretKey: secretKey ?? this.secretKey,
      tokenType: tokenType ?? this.tokenType,
      mapToken: mapToken ?? this.mapToken,
    );
  }
}
