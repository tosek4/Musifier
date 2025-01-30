import 'package:musifier/models/playLists.dart';

class Category {
  final int id;
  final String name;
  final String icon;
  final List<Playlists> playlists;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.playlists,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var playlistsFromJson = ((json['playlists'] ?? []) as List);

    List<Playlists> playlistsList =
        (playlistsFromJson.map((i) => Playlists.fromJson(i)).toList());

    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      playlists: playlistsList,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, icon: $icon, playlist: $playlists)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'playlists': playlists,
    };
  }
}
