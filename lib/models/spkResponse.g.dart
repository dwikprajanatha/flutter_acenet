// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spkResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpkResponse _$SpkResponseFromJson(Map<String, dynamic> json) {
  return SpkResponse()
    ..success = json['success'] as bool
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SpkDetail.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SpkResponseToJson(SpkResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data
    };
