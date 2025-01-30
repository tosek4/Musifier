class Playlists {
  final int id;
  final String name;
  final String description;
  final String image;
  final int tracks;
  final String externalId;

  Playlists({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.tracks,
    required this.externalId,
  });

  factory Playlists.fromJson(Map<String, dynamic> json) {
    return Playlists(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      tracks: json['tracks'],
      externalId: json['externalId'],
    );
  }

  toList() {}
}
