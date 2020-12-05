import 'package:json_annotation/json_annotation.dart';

part 'teknisi.g.dart';

@JsonSerializable()
class Teknisi {
    Teknisi();

    String nama;
    num id;
    
    factory Teknisi.fromJson(Map<String,dynamic> json) => _$TeknisiFromJson(json);
    Map<String, dynamic> toJson() => _$TeknisiToJson(this);
}
