// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobDoneCount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDoneCount _$JobDoneCountFromJson(Map<String, dynamic> json) {
  return JobDoneCount()
    ..monthly_count = json['monthly_count'] as num
    ..weekly_count = json['weekly_count'] as num;
}

Map<String, dynamic> _$JobDoneCountToJson(JobDoneCount instance) =>
    <String, dynamic>{
      'monthly_count': instance.monthly_count,
      'weekly_count': instance.weekly_count
    };
