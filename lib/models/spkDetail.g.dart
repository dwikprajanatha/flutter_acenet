// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spkDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpkDetail _$SpkDetailFromJson(Map<String, dynamic> json) {
  return SpkDetail()
    ..id = json['id'] as num
    ..id_customer = json['id_customer'] as num
    ..id_admin = json['id_admin'] as num
    ..no_spk = json['no_spk'] as String
    ..ket_pekerjaan = json['ket_pekerjaan'] as String
    ..tgl_pekerjaan = json['tgl_pekerjaan'] as String
    ..jam_mulai = json['jam_mulai'] as String
    ..jam_selesai = json['jam_selesai'] as String
    ..download_speed = json['download_speed'] as String
    ..upload_speed = json['upload_speed'] as String
    ..ket_lanjutan = json['ket_lanjutan'] as String
    ..status = json['status'] as String
    ..nama = json['nama'] as String
    ..jenis_layanan = json['jenis_layanan'] as String
    ..no_telp = json['no_telp'] as String
    ..alamat = json['alamat'] as String
    ..tgl_instalasi = json['tgl_instalasi'] as String
    ..tgl_trial = json['tgl_trial'] as String
    ..teknisi = (json['teknisi'] as List)
        ?.map((e) =>
            e == null ? null : Teknisi.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..ttdCustomer = json['ttdCustomer'] as String
    ..ttdTeknisi = json['ttdTeknisi'] as String
    ..fotoBukti = json['fotoBukti'] as String  ;
}

Map<String, dynamic> _$SpkDetailToJson(SpkDetail instance) => <String, dynamic>{
      'id': instance.id,
      'id_customer': instance.id_customer,
      'id_admin': instance.id_admin,
      'no_spk': instance.no_spk,
      'ket_pekerjaan': instance.ket_pekerjaan,
      'tgl_pekerjaan': instance.tgl_pekerjaan,
      'jam_mulai': instance.jam_mulai,
      'jam_selesai': instance.jam_selesai,
      'download_speed': instance.download_speed,
      'upload_speed': instance.upload_speed,
      'ket_lanjutan': instance.ket_lanjutan,
      'status': instance.status,
      'nama': instance.nama,
      'jenis_layanan': instance.jenis_layanan,
      'no_telp': instance.no_telp,
      'alamat': instance.alamat,
      'tgl_instalasi': instance.tgl_instalasi,
      'tgl_trial': instance.tgl_trial,
      'teknisi': instance.teknisi,
      'ttdCustomer': instance.ttdCustomer,
      'ttdTeknisi': instance.ttdTeknisi,
      'fotoBukti': instance.fotoBukti,
    };
