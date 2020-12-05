// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..nama = json['nama'] as String
    ..avatar = json['avatar'] as String
    ..id = json['id'] as num
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..access_token = json['access_token'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nama': instance.nama,
      'avatar': instance.avatar,
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'access_token': instance.access_token
    };
