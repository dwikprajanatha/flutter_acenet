import 'package:json_annotation/json_annotation.dart';
import "spkDetail.dart";
part 'spkResponse.g.dart';

@JsonSerializable()
class SpkResponse {
    SpkResponse();

    bool success;
    String message;
    List<SpkDetail> data;
    
    factory SpkResponse.fromJson(Map<String,dynamic> json) => _$SpkResponseFromJson(json);
    Map<String, dynamic> toJson() => _$SpkResponseToJson(this);
}
