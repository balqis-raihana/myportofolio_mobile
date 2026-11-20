import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan entri Edukasi ke portofolio.
class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  // --- controllers & state ---
  final _institutionController = TextEditingController();
  final _majorController = TextEditingController();
  final _yearStartController = TextEditingController();
  final _yearEndController = TextEditingController();
  final _gpaController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _degree = 'S1';

  /// Dipanggil saat tombol Simpan ditekan.
  /// Memvalidasi form; jika valid, tampilkan AlertDialog ringkasan.
  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final institution = _institutionController.text.trim();
    final major = _majorController.text.trim();
    final yearStart = _yearStartController.text.trim();
    final yearEnd = _yearEndController.text.trim();
    final gpa = _gpaController.text.trim();
    final description = _descriptionController.text.trim();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Data Edukasi Tersimpan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _summaryRow('Institusi', institution),
              _summaryRow('Program Studi', major),
              _summaryRow('Tingkat', _degree),
              _summaryRow(
                'Periode',
                yearEnd.isEmpty
                    ? '$yearStart – sekarang'
                    : '$yearStart – $yearEnd',
              ),
              if (gpa.isNotEmpty) _summaryRow('IPK', gpa),
              if (description.isNotEmpty)
                _summaryRow('Deskripsi', description),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _formKey.currentState!.reset();
              setState(() => _degree = 'S1');
              _institutionController.clear();
              _majorController.clear();
              _yearStartController.clear();
              _yearEndController.clear();
              _gpaController.clear();
              _descriptionController.clear();
            },
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  /// Widget helper untuk satu baris ringkasan di dalam dialog.
  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  static const List<String> _degreeOptions = [
    'D3',
    'D4',
    'S1',
    'S2',
    'S3',
    'Profesi',
    'Lainnya',
  ];

  @override
  void dispose() {
    _institutionController.dispose();
    _majorController.dispose();
    _yearStartController.dispose();
    _yearEndController.dispose();
    _gpaController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Edukasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Nama Institusi ──────────────────────────────────────
              TextFormField(
                controller: _institutionController,
                decoration: const InputDecoration(
                  labelText: 'Nama Institusi *',
                  hintText: 'Contoh: Universitas Indonesia',
                  prefixIcon: Icon(Icons.school_outlined),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama institusi wajib diisi.';
                  }
                  if (value.trim().length > 100) {
                    return 'Nama institusi maksimal 100 karakter.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Program Studi ────────────────────────────────────────
              TextFormField(
                controller: _majorController,
                decoration: const InputDecoration(
                  labelText: 'Program Studi / Jurusan *',
                  hintText: 'Contoh: Ilmu Komputer',
                  prefixIcon: Icon(Icons.menu_book_outlined),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Program studi wajib diisi.';
                  }
                  if (value.trim().length > 100) {
                    return 'Program studi maksimal 100 karakter.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Tingkat Pendidikan (Dropdown) ─────────────────────────
              DropdownButtonFormField<String>(
                value: _degree,
                decoration: const InputDecoration(
                  labelText: 'Tingkat Pendidikan *',
                  prefixIcon: Icon(Icons.grade_outlined),
                  border: OutlineInputBorder(),
                ),
                items: _degreeOptions
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _degree = value);
                },
                validator: (value) =>
                    value == null ? 'Pilih tingkat pendidikan.' : null,
              ),
              const SizedBox(height: 16),

              // ── Tahun Masuk & Tahun Lulus ────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _yearStartController,
                      decoration: const InputDecoration(
                        labelText: 'Tahun Masuk *',
                        hintText: '2021',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Wajib diisi.';
                        }
                        final year = int.tryParse(value.trim());
                        if (year == null || year < 1900 || year > 2100) {
                          return 'Tahun tidak valid.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _yearEndController,
                      decoration: const InputDecoration(
                        labelText: 'Tahun Lulus',
                        hintText: '2025 (opsional)',
                        prefixIcon: Icon(Icons.event_available_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return null; // opsional
                        }
                        final yearEnd = int.tryParse(value.trim());
                        if (yearEnd == null || yearEnd < 1900 || yearEnd > 2100) {
                          return 'Tahun tidak valid.';
                        }
                        final yearStart =
                            int.tryParse(_yearStartController.text.trim());
                        if (yearStart != null && yearEnd < yearStart) {
                          return 'Harus ≥ tahun masuk.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── IPK ──────────────────────────────────────────────────
              TextFormField(
                controller: _gpaController,
                decoration: const InputDecoration(
                  labelText: 'IPK',
                  hintText: 'Contoh: 3.85 (opsional)',
                  prefixIcon: Icon(Icons.bar_chart_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return null;
                  final gpa = double.tryParse(value.trim());
                  if (gpa == null || gpa < 0.0 || gpa > 4.0) {
                    return 'IPK harus antara 0.00 – 4.00.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Deskripsi ─────────────────────────────────────────────
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi / Pencapaian',
                  hintText: 'Deskripsikan pengalaman atau pencapaian (opsional)',
                  prefixIcon: Icon(Icons.notes_outlined),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                maxLength: 500,
              ),
              const SizedBox(height: 24),

              // ── Tombol Simpan ─────────────────────────────────────────
              ElevatedButton.icon(
                onPressed: _onSave,
                icon: const Icon(Icons.save_outlined),
                label: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
