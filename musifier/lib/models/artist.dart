class Artist {
  final int id;
  final String name;
  final String externalId;

  Artist({required this.id, required this.name, required this.externalId});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      externalId: json['externalId'],
    );
  }
}