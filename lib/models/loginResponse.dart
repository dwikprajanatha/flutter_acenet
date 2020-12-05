import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'loginResponse.g.dart';

@JsonSerializable()
class LoginResponse {
    LoginResponse();

    bool success;
    String messages;
    User data;
    
    factory LoginResponse.fromJson(Map<String,dynamic> json) => _$LoginResponseFromJson(json);
    Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
