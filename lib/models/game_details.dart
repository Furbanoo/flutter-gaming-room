import 'dart:convert';

import 'package:gameroom/models/game.dart';

class GameDetails extends Game {
  List? artworks;
  List? companies;
  List? dlcs;
  List? franchises;
  List? gameModes;
  List? genres;
  List? languageSupports;
  List? parentGame;
  List? platforms;
  List? releaseDate;
  List? screenshots;
  List? similarGames;
  int? status;
  String? storyline;
  List? themes;
  int? totalRatingCount;
  List? videos;
  List? websites;

  GameDetails({
    required super.id,
    required super.cover,
    required super.name,
    super.coverUrl,
    super.firstReleaseDate,
    super.totalRating,
    super.summary,
    this.artworks,
    this.companies,
    this.dlcs,
    this.franchises,
    this.gameModes,
    this.genres,
    this.languageSupports,
    this.platforms,
    this.releaseDate,
    this.screenshots,
    this.similarGames,
    this.status,
    this.storyline,
    this.themes,
    this.totalRatingCount,
    this.videos,
    this.websites,
  });

  get length => null;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cover': {
        "image_id": cover,
      },
      'artworks': artworks?.map((imageId) => {"image_id": imageId}).toList(),
      'involved_companies': companies
          ?.map((company) => {
                "company": {
                  "name": company.name,
                  "logo": {"image_id": company.logo}
                }
              })
          .toList(),
      'dlcs': dlcs?.map((dlc) => dlc.toMap()).toList(),
      'franchises': franchises?.map((franchise) => {"id": franchises}).toList(),
      'first_release_date': firstReleaseDate,
      'game_modes': gameModes?.map((mode) => {"name": mode}).toList(),
      'genres': genres?.map((genre) => {"name": genre}).toList(),
      'language_supports': languageSupports
          ?.map((language) => {
                "language": {"name": language.name, "id": language.id},
                "language_support_type": {
                  "name": language.nameType,
                  "id": language.id
                }
              })
          .toList(),
      'platforms': platforms
          ?.map((platform) => {
                "name": platform.name,
                "platform_logo": {"image_id": platform.logo}
              })
          .toList(),
      'release_dates': releaseDate?.map((date) => date.toMap()).toList(),
      'screenshots':
          screenshots?.map((imageId) => {"image_id": imageId}).toList(),
      'similar_games': similarGames?.map((game) => game.toMap()).toList(),
      'status': status,
      'storyline': storyline,
      'summary': summary,
      'themes': themes?.map((theme) => {"name": theme}).toList(),
      'total_rating': totalRating,
      'total_rating_count': totalRatingCount,
      'videos': videos
          ?.map((video) => {"name": video.name, "video_id": video.videoId})
          .toList(),
      'websites': websites
          ?.map((website) => {"url": website.url, "category": website.category})
          .toList(),
    };
  }

  factory GameDetails.fromMap(Map<String, dynamic> map) {
    return GameDetails(
      id: map['id'],
      name: map['name'],
      cover: map['cover']?['image_id'] ?? 'nocover',
      coverUrl:
          "https://images.igdb.com/igdb/image/upload/t_cover_big/${map['cover']?['image_id'] ?? 'nocover'}.png",
      firstReleaseDate: map['first_release_date'] ?? -1,
      totalRating: map['total_rating'] ?? 0.0,
      artworks:
          map['artworks']?.map((artwork) => artwork['image_id']).toList() ?? [],
      companies: map['involved_companies']
              ?.map((involvedCompany) => Company(
                  involvedCompany['company']['name'],
                  involvedCompany['company']['logo']?['image_id']))
              .toList() ??
          [],
      dlcs: map['dlcs']?.map((game) => Game.fromMap(game)).toList() ?? [],
      franchises:
          map['franchises']?.map((franchise) => franchise['id']).toList() ?? [],
      gameModes: map['game_modes']?.map((mode) => mode['name']).toList() ?? [],
      genres: map['genres']?.map((genre) => genre['name']).toList() ?? [],
      languageSupports: map['language_supports']
              ?.map((language) => Language(language['language']?['name'],
                  language['language_support_type']?['id']))
              .toList() ??
          [],
      platforms: map['platforms']
              ?.map((platform) => Platform(
                  platform['name'], platform['platform_logo']?['image_id']))
              .toList() ??
          [],
      releaseDate:
          map['release_dates']?.map((date) => date['date']).toList() ?? [],
      screenshots: map['screenshots']
              ?.map((screenshot) => screenshot['image_id'])
              .toList() ??
          [],
      similarGames:
          map['similar_games']?.map((game) => Game.fromMap(game)).toList() ??
              [],
      status: map['status'] ?? -1,
      storyline: map['storyline'],
      summary: map['summary'] ?? 'No Description',
      themes: map['themes']?.map((theme) => theme['name']).toList() ?? [],
      totalRatingCount: map['total_rating_count'] ?? 0,
      videos: map['videos']
              ?.map((video) => Video(video['name'], video['video_id']))
              .toList() ??
          [],
      websites: map['websites']
              ?.map((website) => Website(website['url'], website['category']))
              .toList() ??
          [],
    );
  }

  factory GameDetails.fromJson(String source) =>
      GameDetails.fromMap(json.decode(source));
}

class Video {
  String name;
  String videoId;

  Video(this.name, this.videoId);
}

class Website {
  String url;
  int category;

  Website(this.url, this.category);
}

class Platform {
  String name;
  String? logo;

  Platform(this.name, this.logo);
}

class Company {
  String name;
  String? logo;

  Company(this.name, this.logo);
}

class Language {
  String name;
  int nameTypeId;

  Language(this.name, this.nameTypeId);
}
