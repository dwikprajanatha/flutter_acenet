import 'package:json_annotation/json_annotation.dart';
import "teknisi.dart";
part 'spkDetail.g.dart';

@JsonSerializable()
class SpkDetail {
    SpkDetail();

    num id;
    num id_customer;
    num id_admin;
    String no_spk;
    String ket_pekerjaan;
    String tgl_pekerjaan;
    String jam_mulai;
    String jam_selesai;
    String download_speed;
    String upload_speed;
    String ket_lanjutan;
    String status;
    String nama;
    String jenis_layanan;
    String no_telp;
    String alamat;
    String tgl_instalasi;
    String tgl_trial;
    List<Teknisi> teknisi;
    String ttdCustomer;
    String ttdTeknisi;
    String fotoBukti;

    factory SpkDetail.fromJson(Map<String,dynamic> json) => _$SpkDetailFromJson(json);
    Map<String, dynamic> toJson() => _$SpkDetailToJson(this);
}
