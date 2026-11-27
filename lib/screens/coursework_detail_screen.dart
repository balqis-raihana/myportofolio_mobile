import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/coursework.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class CourseworkDetailScreen extends StatefulWidget {
  const CourseworkDetailScreen({super.key, required this.coursework});

  final Coursework coursework;

  @override
  State<CourseworkDetailScreen> createState() => _CourseworkDetailScreenState();
}

class _CourseworkDetailScreenState extends State<CourseworkDetailScreen> {
  late Coursework _coursework;
  bool _isStarring = false;

  @override
  void initState() {
    super.initState();
    _coursework = widget.coursework;
  }

  Future<void> _toggleStar() async {
    final authenticated = await ensureLoggedIn(context);
    if (!authenticated || !mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null || _coursework.id == null) return;

    setState(() {
      _isStarring = true;
    });

    try {
      final updated = await context.read<ApiClient>().toggleCourseworkStar(
        _coursework.id!,
        token: token,
      );
      if (!mounted) return;
      setState(() {
        _coursework = updated;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            updated.isStarred
                ? 'Berhasil memberi bintang!'
                : 'Bintang dihapus.',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memberi bintang: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isStarring = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_coursework.name),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: _isStarring
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    _coursework.isStarred ? Icons.star : Icons.star_border,
                    color: _coursework.isStarred ? Colors.amber : Colors.white,
                  ),
            tooltip: _coursework.isStarred ? 'Hapus Bintang' : 'Beri Bintang',
            onPressed: _isStarring ? null : _toggleStar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _coursework.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _coursework.category,
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${_coursework.credits} SKS',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(Icons.star, color: Colors.amber.shade700, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${_coursework.starCount} stars',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Deskripsi Mata Kuliah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              _coursework.description,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
            if (_coursework.journal.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Learning Journal / Catatan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  _coursework.journal,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ),
            ],
            if (_coursework.starredByNames.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Diberi Bintang Oleh',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                _coursework.starredByNames,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
