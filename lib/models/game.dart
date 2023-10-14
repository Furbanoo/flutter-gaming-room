import 'dart:convert';

class Game {
  int id;
  String cover;
  String name;
  String? coverUrl;
  int? firstReleaseDate;
  double? totalRating;
  String? summary;

  Game({
    required this.id,
    required this.cover,
    required this.name,
    this.coverUrl,
    this.firstReleaseDate,
    this.totalRating,
    this.summary,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cover': {
        "image_id": cover,
      },
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'],
      name: map['name'],
      cover: map['cover']?['image_id'] ?? 'nocover',
      coverUrl:
          "https://images.igdb.com/igdb/image/upload/t_cover_big/${map['cover']?['image_id'] ?? 'nocover'}.png",
      totalRating: map['total_rating'] ?? 0.0,
      firstReleaseDate: map['first_release_date'] ?? -1,
      summary: map['summary'] ?? 'No Description',
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) => Game.fromMap(json.decode(source));
}
