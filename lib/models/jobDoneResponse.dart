import 'package:json_annotation/json_annotation.dart';
import "jobDoneCount.dart";
part 'jobDoneResponse.g.dart';

@JsonSerializable()
class JobDoneResponse {
    JobDoneResponse();

    bool success;
    String message;
    JobDoneCount data;
    
    factory JobDoneResponse.fromJson(Map<String,dynamic> json) => _$JobDoneResponseFromJson(json);
    Map<String, dynamic> toJson() => _$JobDoneResponseToJson(this);
}
