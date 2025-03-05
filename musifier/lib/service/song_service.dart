import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/songSearch.dart';

class SongService {
  static const String _baseUrl =
      'https://musifier.circles-dev.tech/server/search';

  Future<List<SongSearch>> fetchSongs(String query) async {
    if (query.isEmpty) return [];

    final response =
        await http.get(Uri.parse('$_baseUrl?query=$query&type=track'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List tracks = data['tracks'] ?? [];
      return tracks.map((json) => SongSearch.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
