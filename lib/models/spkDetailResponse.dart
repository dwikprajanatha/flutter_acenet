import 'package:json_annotation/json_annotation.dart';
import "spkDetail.dart";
part 'spkDetailResponse.g.dart';

@JsonSerializable()
class SpkDetailResponse {
    SpkDetailResponse();

    bool success;
    String message;
    SpkDetail data;
    
    factory SpkDetailResponse.fromJson(Map<String,dynamic> json) => _$SpkDetailResponseFromJson(json);
    Map<String, dynamic> toJson() => _$SpkDetailResponseToJson(this);
}
