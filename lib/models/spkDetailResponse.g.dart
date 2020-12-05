// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spkDetailResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpkDetailResponse _$SpkDetailResponseFromJson(Map<String, dynamic> json) {
  return SpkDetailResponse()
    ..success = json['success'] as bool
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : SpkDetail.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SpkDetailResponseToJson(SpkDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data
    };
