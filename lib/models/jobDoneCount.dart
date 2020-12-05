import 'package:json_annotation/json_annotation.dart';

part 'jobDoneCount.g.dart';

@JsonSerializable()
class JobDoneCount {
    JobDoneCount();

    num monthly_count;
    num weekly_count;
    
    factory JobDoneCount.fromJson(Map<String,dynamic> json) => _$JobDoneCountFromJson(json);
    Map<String, dynamic> toJson() => _$JobDoneCountToJson(this);
}
