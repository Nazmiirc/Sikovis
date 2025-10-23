class HistoryModel {
  final int id;
  final String nama;
  final String telefon;
  final String alamat;
  final String jasa;
  final String tanggalKedatangan;
  final String createdAt;

  // Map asli yang Anda berikan: nama jasa -> ID
  static const Map<String, int> _originalServiceMap = {
    'Servis Ringan': 2,
    'Servis Sedang': 3,
    'Service Berat': 4,
  };

  // Map yang dibalik: ID -> nama jasa
  // Ini yang akan kita gunakan untuk mencari nama jasa berdasarkan ID
  static final Map<int, String> _jasaNamesById =
      _originalServiceMap.map((key, value) => MapEntry(value, key));

  HistoryModel({
    required this.id,
    required this.nama,
    required this.telefon,
    required this.alamat,
    required this.jasa,
    required this.tanggalKedatangan,
    required this.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    final int jasaId = json['jasa_id'];
    // Dapatkan nama jasa dari map yang sudah dibalik
    final String jasaName =
        _jasaNamesById[jasaId] ?? 'Jasa Tidak Dikenal (ID: $jasaId)';

    return HistoryModel(
      id: json['id'],
      nama: json['nama_pemesan'],
      telefon: json['telefon_pemesan'],
      alamat: json['alamat_pemesan'],
      jasa: jasaName, // Menggunakan nama jasa yang sudah dipetakan
      tanggalKedatangan: json['tanggal_kedatangan'],
      createdAt: json['created_at'],
    );
  }
}