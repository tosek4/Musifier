import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:musifier/service/song_service.dart';
import 'package:musifier/widgets/navBar.dart';
import '../models/songSearch.dart';

class SongSearchPage extends HookWidget {
  const SongSearchPage({super.key});
  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final query = useState('');

    final future =
        useMemoized(() => SongService().fetchSongs(query.value), [query.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Songs'),
        backgroundColor: const Color(0xFF1B1B37),
      ),
      backgroundColor: const Color(0xFF1B1B37),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search for a song',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                filled: true,
                fillColor: Color(0xFF1B1B37),
              ),
              onChanged: (value) => query.value = value,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<SongSearch>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No songs found'));
                  }

                  final songs = snapshot.data!;
                  return ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      return ListTile(
                        leading: song.cover.isNotEmpty
                            ? Image.network(song.cover,
                                width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.music_note),
                        title: Text(song.title),
                        subtitle: Text(song.artist),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationWidget(
        currentIndex: _currentIndex,
      ),
    );
  }
}
