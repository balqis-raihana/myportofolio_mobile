/// Model data untuk satu entri Edukasi pada portofolio.
class EducationEntry {
  /// Nama institusi / universitas.
  final String institution;

  /// Program studi atau jurusan.
  final String major;

  /// Tingkat pendidikan (mis. S1, S2, D3, dll.).
  final String degree;

  /// Tahun masuk (misalnya 2021).
  final int yearStart;

  /// Tahun lulus / perkiraan lulus (misalnya 2025).
  /// Boleh null jika masih aktif.
  final int? yearEnd;

  /// Indeks Prestasi Kumulatif (opsional).
  final double? gpa;

  /// Deskripsi singkat atau pencapaian selama studi (opsional).
  final String description;

  const EducationEntry({
    required this.institution,
    required this.major,
    required this.degree,
    required this.yearStart,
    this.yearEnd,
    this.gpa,
    this.description = '',
  });
}
