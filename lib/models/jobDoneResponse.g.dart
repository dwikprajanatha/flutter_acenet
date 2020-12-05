// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobDoneResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDoneResponse _$JobDoneResponseFromJson(Map<String, dynamic> json) {
  return JobDoneResponse()
    ..success = json['success'] as bool
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : JobDoneCount.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$JobDoneResponseToJson(JobDoneResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data
    };
