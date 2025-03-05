class Song {
  final int id;
  final String name;
  final String image;
  final String artists;
  final int duration;

  Song({
    required this.id,
    required this.name,
    required this.image,
    required this.artists,
    required this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? '',
      duration: json['duration'] ?? 0,
      artists: json['artists']
    );
  }
}
