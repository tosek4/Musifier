class Song {
  final int id;
  final String name;
  final String image;
  final String artists;

  Song(
      {required this.id,
      required this.name,
      required this.image,
      required this.artists});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      artists: json['artists'],
    );
  }
}
