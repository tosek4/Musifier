class SongSearch {
  final String title;
  final String artist;
  final String cover;

  SongSearch({required this.title, required this.artist, required this.cover});

  factory SongSearch.fromJson(Map<String, dynamic> json) {
    return SongSearch(
      title: json['title'] ?? 'Unknown Title',
      artist: json['artist'] ?? 'Unknown Artist',
      cover: json['cover'] ?? '',
    );
  }
}
