// To parse this JSON data, do
//
//     final searchResults = searchResultsFromJson(jsonString);

import 'dart:convert';

SearchResults searchResultsFromJson(String str) =>
    SearchResults.fromJson(json.decode(str));

String searchResultsToJson(SearchResults data) => json.encode(data.toJson());

class SearchResults {
  SearchResults({
    this.albums,
    this.tracks,
    this.shows,
    this.episodes,
  });

  Albums? albums;
  Tracks? tracks;
  Albums? shows;
  Episodes? episodes;

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        albums: Albums.fromJson(json["albums"]),
        tracks: Tracks.fromJson(json["tracks"]),
        shows: Albums.fromJson(json["shows"]),
        episodes: Episodes.fromJson(json["episodes"]),
      );

  Map<String, dynamic> toJson() => {
        "albums": albums!.toJson(),
        "tracks": tracks!.toJson(),
        "shows": shows!.toJson(),
        "episodes": episodes!.toJson(),
      };
}

class Albums {
  Albums({
    this.href,
    this.items,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
  });

  String? href;
  List<AlbumElement>? items;
  int? limit;
  dynamic next;
  int? offset;
  dynamic previous;
  int? total;

  factory Albums.fromJson(Map<String, dynamic> json) => Albums(
        href: json["href"],
        items: List<AlbumElement>.from(
            json["items"].map((x) => AlbumElement.fromJson(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "total": total,
      };
}

class AlbumElement {
  AlbumElement({
    this.albumType,
    this.artists,
    this.availableMarkets,
    this.externalUrls,
    this.href,
    this.id,
    this.images,
    this.name,
    this.releaseDate,
    this.releaseDatePrecision,
    this.totalTracks,
    this.type,
    this.uri,
  });

  AlbumTypeEnum? albumType;
  List<Artist>? artists;
  List<String>? availableMarkets;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Image>? images;
  String? name;
  String? releaseDate;
  ReleaseDatePrecision? releaseDatePrecision;
  int? totalTracks;
  AlbumTypeEnum? type;
  String? uri;

  factory AlbumElement.fromJson(Map<String, dynamic> json) => AlbumElement(
        albumType: albumTypeEnumValues.map![json["album_type"]],
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        availableMarkets:
            List<String>.from(json["available_markets"].map((x) => x)),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        name: json["name"],
        releaseDate: json["release_date"],
        releaseDatePrecision:
            releaseDatePrecisionValues.map![json["release_date_precision"]],
        totalTracks: json["total_tracks"],
        type: albumTypeEnumValues.map![json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "album_type": albumTypeEnumValues.reverse[albumType],
        "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
        "available_markets":
            List<dynamic>.from(availableMarkets!.map((x) => x)),
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "name": name,
        "release_date": releaseDate,
        "release_date_precision":
            releaseDatePrecisionValues.reverse[releaseDatePrecision],
        "total_tracks": totalTracks,
        "type": albumTypeEnumValues.reverse[type],
        "uri": uri,
      };
}

enum AlbumTypeEnum { ALBUM, SINGLE, COMPILATION }

final albumTypeEnumValues = EnumValues({
  "album": AlbumTypeEnum.ALBUM,
  "compilation": AlbumTypeEnum.COMPILATION,
  "single": AlbumTypeEnum.SINGLE
});

class Artist {
  Artist({
    this.externalUrls,
    this.href,
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? name;
  ArtistType? type;
  String? uri;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        name: json["name"],
        type: artistTypeValues.map![json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "id": id,
        "name": name,
        "type": artistTypeValues.reverse[type],
        "uri": uri,
      };
}

class ExternalUrls {
  ExternalUrls({
    this.spotify,
  });

  String? spotify;

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
      );

  Map<String, dynamic> toJson() => {
        "spotify": spotify,
      };
}

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({"artist": ArtistType.ARTIST});

class Image {
  Image({
    this.height,
    this.url,
    this.width,
  });

  int? height;
  String? url;
  int? width;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        height: json["height"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
      };
}

enum ReleaseDatePrecision { DAY, YEAR }

final releaseDatePrecisionValues = EnumValues(
    {"day": ReleaseDatePrecision.DAY, "year": ReleaseDatePrecision.YEAR});

class Episodes {
  Episodes({
    this.href,
    this.items,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
  });

  String? href;
  List<EpisodesItem>? items;
  int? limit;
  dynamic next;
  int? offset;
  dynamic previous;
  int? total;

  factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
        href: json["href"],
        items: List<EpisodesItem>.from(
            json["items"].map((x) => EpisodesItem.fromJson(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "total": total,
      };
}

class EpisodesItem {
  EpisodesItem({
    this.audioPreviewUrl,
    this.description,
    this.durationMs,
    this.explicit,
    this.externalUrls,
    this.href,
    this.htmlDescription,
    this.id,
    this.images,
    this.isExternallyHosted,
    this.isPlayable,
    this.language,
    this.languages,
    this.name,
    this.releaseDate,
    this.releaseDatePrecision,
    this.resumePoint,
    this.type,
    this.uri,
  });

  String? audioPreviewUrl;
  String? description;
  int? durationMs;
  bool? explicit;
  ExternalUrls? externalUrls;
  String? href;
  String? htmlDescription;
  String? id;
  List<Image>? images;
  bool? isExternallyHosted;
  bool? isPlayable;
  String? language;
  List<String>? languages;
  String? name;
  DateTime? releaseDate;
  ReleaseDatePrecision? releaseDatePrecision;
  ResumePoint? resumePoint;
  String? type;
  String? uri;

  factory EpisodesItem.fromJson(Map<String, dynamic> json) => EpisodesItem(
        audioPreviewUrl: json["audio_preview_url"],
        description: json["description"],
        durationMs: json["duration_ms"],
        explicit: json["explicit"],
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        htmlDescription: json["html_description"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        isExternallyHosted: json["is_externally_hosted"],
        isPlayable: json["is_playable"],
        language: json["language"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        name: json["name"],
        releaseDate: DateTime.parse(json["release_date"]),
        releaseDatePrecision:
            releaseDatePrecisionValues.map![json["release_date_precision"]],
        resumePoint: ResumePoint.fromJson(json["resume_point"]),
        type: json["type"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "audio_preview_url": audioPreviewUrl,
        "description": description,
        "duration_ms": durationMs,
        "explicit": explicit,
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "html_description": htmlDescription,
        "id": id,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "is_externally_hosted": isExternallyHosted,
        "is_playable": isPlayable,
        "language": language,
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "name": name,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "release_date_precision":
            releaseDatePrecisionValues.reverse[releaseDatePrecision],
        "resume_point": resumePoint!.toJson(),
        "type": type,
        "uri": uri,
      };
}

class ResumePoint {
  ResumePoint({
    this.fullyPlayed,
    this.resumePositionMs,
  });

  bool? fullyPlayed;
  int? resumePositionMs;

  factory ResumePoint.fromJson(Map<String, dynamic> json) => ResumePoint(
        fullyPlayed: json["fully_played"],
        resumePositionMs: json["resume_position_ms"],
      );

  Map<String, dynamic> toJson() => {
        "fully_played": fullyPlayed,
        "resume_position_ms": resumePositionMs,
      };
}

class Tracks {
  Tracks({
    this.href,
    this.items,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
  });

  String? href;
  List<TracksItem>? items;
  int? limit;
  String? next;
  int? offset;
  dynamic previous;
  int? total;

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        href: json["href"],
        items: List<TracksItem>.from(
            json["items"].map((x) => TracksItem.fromJson(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "total": total,
      };
}

class TracksItem {
  TracksItem({
    this.album,
    this.artists,
    this.availableMarkets,
    this.discNumber,
    this.durationMs,
    this.explicit,
    this.externalIds,
    this.externalUrls,
    this.href,
    this.id,
    this.isLocal,
    this.name,
    this.popularity,
    this.previewUrl,
    this.trackNumber,
    this.type,
    this.uri,
  });

  AlbumElement? album;
  List<Artist>? artists;
  List<String>? availableMarkets;
  int? discNumber;
  int? durationMs;
  bool? explicit;
  ExternalIds? externalIds;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  bool? isLocal;
  String? name;
  int? popularity;
  String? previewUrl;
  int? trackNumber;
  PurpleType? type;
  String? uri;

  factory TracksItem.fromJson(Map<String, dynamic> json) => TracksItem(
        album: AlbumElement.fromJson(json["album"]),
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        availableMarkets:
            List<String>.from(json["available_markets"].map((x) => x)),
        discNumber: json["disc_number"],
        durationMs: json["duration_ms"],
        explicit: json["explicit"],
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        isLocal: json["is_local"],
        name: json["name"],
        popularity: json["popularity"],
        previewUrl: json["preview_url"],
        trackNumber: json["track_number"],
        type: purpleTypeValues.map![json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "album": album!.toJson(),
        "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
        "available_markets":
            List<dynamic>.from(availableMarkets!.map((x) => x)),
        "disc_number": discNumber,
        "duration_ms": durationMs,
        "explicit": explicit,
        "external_ids": externalIds!.toJson(),
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "id": id,
        "is_local": isLocal,
        "name": name,
        "popularity": popularity,
        "preview_url": previewUrl,
        "track_number": trackNumber,
        "type": purpleTypeValues.reverse[type],
        "uri": uri,
      };
}

class ExternalIds {
  ExternalIds({
    this.isrc,
  });

  String? isrc;

  factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        isrc: json["isrc"],
      );

  Map<String, dynamic> toJson() => {
        "isrc": isrc,
      };
}

enum PurpleType { TRACK }

final purpleTypeValues = EnumValues({"track": PurpleType.TRACK});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
