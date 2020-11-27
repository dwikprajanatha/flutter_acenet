class CustomerModel {
  final String id,
      nama_pelanggan,
      no_telp,
      jenis_layanan,
      tgl_instalasi,
      tgl_trial,
      alamat;

  CustomerModel(
      {this.id,
      this.nama_pelanggan,
      this.no_telp,
      this.jenis_layanan,
      this.tgl_instalasi,
      this.tgl_trial,
      this.alamat});

  factory CustomerModel.fromJson(Map<String, dynamic> object) {
    return CustomerModel(
      id: object['id'],
      nama_pelanggan: object['nama_pelanggan'],
      no_telp: object['no_telp'],
      jenis_layanan: object['jenis_layanan'],
      tgl_instalasi: object['tgl_instalasi'],
      tgl_trial: object['tgl_trial'],
      alamat: object['alamat'],
    );
  }
}
