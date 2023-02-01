import 'package:json_annotation/json_annotation.dart';

part 'verify_otp.g.dart';

// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class Token {
  Token({
    this.token,
    this.isNewUser,
  });

  String? token;
  bool? isNewUser;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}




// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// Token tokenFromJson(String str) => Token.fromJson(json.decode(str));
//
// String tokenToJson(Token data) => json.encode(data.toJson());
//
// class Token {
//   Token({
//     this.token,
//     this.isNewUser,
//   });
//
//   String? token;
//   bool? isNewUser;
//
//   factory Token.fromJson(Map<String, dynamic> json) => Token(
//     token: json["token"],
//     isNewUser: json["isNewUser"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "token": token,
//     "isNewUser": isNewUser,
//   };
// }