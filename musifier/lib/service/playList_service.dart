import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musifier/models/playList.dart';

class PlaylistService {
  static const String _baseUrl = 'https://musifier.circles-dev.tech/server';

  Future<Playlist> fetchPlaylist(int id) async {
    final url = '$_baseUrl/playlists/$id?relations[tracksList][artists]=true';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Playlist.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load playlist');
    }
  }
}
