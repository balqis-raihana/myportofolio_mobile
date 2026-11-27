import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/coursework.dart';
import 'package:myportofolio_mobile/screens/coursework_detail_screen.dart';
import 'package:myportofolio_mobile/screens/coursework_form_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class CourseworkListScreen extends StatefulWidget {
  const CourseworkListScreen({super.key});

  @override
  State<CourseworkListScreen> createState() => _CourseworkListScreenState();
}

class _CourseworkListScreenState extends State<CourseworkListScreen> {
  late Future<List<Coursework>> _courseworkFuture;

  @override
  void initState() {
    super.initState();
    _courseworkFuture = context.read<ApiClient>().getCoursework();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getCoursework();
    setState(() {
      _courseworkFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements: Coursework'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        tooltip: 'Tambah Coursework',
        onPressed: () async {
          final ok = await ensureLoggedIn(context);
          if (!ok || !context.mounted) return;
          final created = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => const CourseworkFormScreen(),
            ),
          );
          if (created == true) {
            _reload();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Coursework>>(
        future: _courseworkFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load coursework: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final courseworkList = snapshot.data ?? const <Coursework>[];
          if (courseworkList.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  child: Center(
                    child: Text(
                      'Belum ada data coursework.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: courseworkList.length,
              itemBuilder: (context, index) {
                final cw = courseworkList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal.shade100,
                      foregroundColor: Colors.teal.shade800,
                      child: Text(
                        '${cw.credits}S',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      cw.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            cw.category,
                            style: TextStyle(
                              color: Colors.teal.shade800,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cw.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          cw.isStarred ? Icons.star : Icons.star_border,
                          color: cw.isStarred ? Colors.amber : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text('${cw.starCount}'),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CourseworkDetailScreen(coursework: cw),
                        ),
                      );
                      _reload();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
