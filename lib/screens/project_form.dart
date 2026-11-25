import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";
  String _techStack = "";
  String _projectUrl = "";
  String _projectImageUrl = "";
  bool _isSubmitting = false;

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.isScheme('http') || uri.isScheme('https')) &&
        uri.host.isNotEmpty;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authenticated = await ensureLoggedIn(context);
    if (!authenticated || !mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      final created = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Proyek Berhasil Disimpan'),
          content: Text(
            'Proyek "${created.title}" berhasil dibuat di database.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi telah berakhir, silakan login kembali.'),
            backgroundColor: Colors.red,
          ),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal menyimpan proyek: ${e.statusCode} ${e.message}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === Title ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Title *",
                  hintText: "Judul Proyek",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                onChanged: (value) => _title = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title cannot be empty.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Tech Stack ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Tech Stack *",
                  hintText: "Contoh: Flutter, Django, PostgreSQL",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.code),
                ),
                onChanged: (value) => _techStack = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Tech Stack cannot be empty.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Project URL ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Project URL *",
                  hintText: "https://github.com/...",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
                onChanged: (value) => _projectUrl = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Project URL cannot be empty.";
                  }
                  if (!_isValidUrl(value.trim())) {
                    return "Masukkan format URL yang valid (mis. http:// atau https://).";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Project Image URL (Optional) ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Project Image URL (Optional)",
                  hintText: "https://example.com/image.png",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image_outlined),
                ),
                keyboardType: TextInputType.url,
                onChanged: (value) => _projectImageUrl = value,
                validator: (value) {
                  if (value != null &&
                      value.trim().isNotEmpty &&
                      !_isValidUrl(value.trim())) {
                    return "Format URL gambar tidak valid.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Description ===
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Description *",
                  hintText: "Deskripsi singkat proyek...",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description cannot be empty.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
