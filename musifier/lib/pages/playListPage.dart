import 'package:flutter/material.dart';
import 'package:musifier/models/category.dart';
import 'package:musifier/models/playList.dart';
import 'package:musifier/models/song.dart';
import 'package:musifier/pages/MusicPlayerPage.dart';
import 'package:musifier/providers/musicPlayerProvider.dart';
import 'package:musifier/service/playList_service.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatefulWidget {
  final int playlistId;

  PlaylistPage({required this.playlistId, required Category category});

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  late Future<Playlist> _playlistFuture;

  @override
  void initState() {
    super.initState();
    _playlistFuture = PlaylistService().fetchPlaylist(widget.playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
        backgroundColor: const Color(0xFF1B1B37),
      ),
      backgroundColor: const Color(0xFF1B1B37),
      body: SafeArea(
        child: FutureBuilder<Playlist>(
          future: _playlistFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }

            final playlist = snapshot.data!;

            return SingleChildScrollView(
              child: Container(
                color: const Color(0xFF1B1B37),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(playlist.image),
                    SizedBox(height: 16),
                    Text(
                      playlist.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      playlist.description,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    playlist.tracksList!.isNotEmpty
                        ? SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: playlist.tracksList!.length,
                        itemBuilder: (context, index) {
                          final track = playlist.tracksList![index];
                          return Container(
                            color: const Color(0xFF1B1B37),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () async {
                                final musicPlayerProvider =
                                Provider.of<MusicPlayerProvider>(context, listen: false);
                                await musicPlayerProvider.setAudio(track.id);
                                musicPlayerProvider.togglePlayPause();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MusicPlayerPage(
                                      songId: track.id,
                                      song: Song(
                                        id: track.id,
                                        name: track.name,
                                        image: track.image,
                                        artists: track.artists.map((artist) => artist.name).join(', '),
                                        duration: track.duration,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                tileColor: const Color(0xFF1B1B37),
                                leading: Image.network(track.image,
                                    width: 50, height: 50, fit: BoxFit.cover),
                                title: Text(track.name, style: TextStyle(color: Colors.white)),
                                subtitle: Text(track.artists
                                    .map((artist) => artist.name)
                                    .join(', '), style: TextStyle(color: Colors.white70)),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                        : const Center(child: Text('No tracks available', style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
