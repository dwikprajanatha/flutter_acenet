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
    ..email = json['email'] as String
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..no_telp = json['no_telp'] as String
    ..access_token = json['access_token'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nama': instance.nama,
      'avatar': instance.avatar,
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'no_telp': instance.no_telp,
      'access_token': instance.access_token
    };
