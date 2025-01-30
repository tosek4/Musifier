import 'package:flutter/material.dart';
import 'package:musifier/models/category.dart';
import 'package:musifier/models/playList.dart';
import 'package:musifier/service/playList_service.dart';

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
        backgroundColor: Color(0xFF1B1B37),
      ),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(playlist.image),
                    SizedBox(height: 16),
                    Text(
                      playlist.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      playlist.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    playlist.tracksList!.isNotEmpty
                        ? SizedBox(
                            height: 400, 
                            child: ListView.builder(
                              itemCount: playlist.tracksList!.length,
                              itemBuilder: (context, index) {
                                final track = playlist.tracksList![index];
                                return ListTile(
                                  leading: Image.network(track.image,
                                      width: 50, height: 50, fit: BoxFit.cover),
                                  title: Text(track.name),
                                  subtitle: Text(track.artists
                                      .map((artist) => artist.name)
                                      .join(', ')),
                                );
                              },
                            ),
                          )
                        : Center(child: Text('No tracks available')),
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
