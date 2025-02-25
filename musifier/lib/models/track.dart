import 'package:musifier/models/artist.dart';

class Track {
  final String name;
  final String externalId;
  final String image;
  final List<Artist> artists;
  final int id;

  Track({
    required this.name,
    required this.externalId,
    required this.image,
    required this.artists,
    required this.id,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    var artistsFromJson = json['artists'] as List;

    List<Artist> artistsList =
        artistsFromJson.map((i) => Artist.fromJson(i)).toList();

    return Track(
      name: json['name'],
      externalId: json['externalId'],
      image: json['image'],
      artists: artistsList,
      id: json['id'],
    );
  }

  @override
  String toString() {
    return 'Track(name: $name, externalId: $externalId, artists: ${artists.map((a) => a.name).join(", ")}, id: $id)';
  }
}
