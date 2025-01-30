import 'package:musifier/models/track.dart';

class Playlist {
  final int id;
  final String name;
  final String description;
  final String image;
  final int tracks;
  final List<Track> tracksList;
  final String externalId;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.tracks,
    required this.externalId,
    required this.tracksList,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    var tracksFromJson = json['tracksList'] as List;

    List<Track> tracksList =
        tracksFromJson.map((i) => Track.fromJson(i)).toList();

    return Playlist(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      tracks: json['tracks'],
      externalId: json['externalId'],
      tracksList: tracksList,
    );
  }

  toList() {}
}
