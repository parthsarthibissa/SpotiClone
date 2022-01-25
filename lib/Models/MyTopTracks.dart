// To parse this JSON data, do
//
//     final myTopTracksModel = myTopTracksModelFromJson(jsonString);

import 'dart:convert';

MyTopTracksModel myTopTracksModelFromJson(String str) =>
    MyTopTracksModel.fromJson(json.decode(str));

String myTopTracksModelToJson(MyTopTracksModel data) =>
    json.encode(data.toJson());

class MyTopTracksModel {
  MyTopTracksModel({
    this.items,
    this.total,
    this.limit,
    this.offset,
    this.previous,
    this.href,
    this.next,
  });

  List<TopTrackItem>? items;
  int? total;
  int? limit;
  int? offset;
  dynamic previous;
  String? href;
  String? next;

  factory MyTopTracksModel.fromJson(Map<String, dynamic> json) =>
      MyTopTracksModel(
        items: List<TopTrackItem>.from(
            json["items"].map((x) => TopTrackItem.fromJson(x))),
        total: json["total"],
        limit: json["limit"],
        offset: json["offset"],
        previous: json["previous"],
        href: json["href"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "total": total,
        "limit": limit,
        "offset": offset,
        "previous": previous,
        "href": href,
        "next": next,
      };
}

class TopTrackItem {
  TopTrackItem({
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

  Album? album;
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
  ItemType? type;
  String? uri;

  factory TopTrackItem.fromJson(Map<String, dynamic> json) => TopTrackItem(
        album: Album.fromJson(json["album"]),
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
        type: itemTypeValues.map![json["type"]],
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
        "type": itemTypeValues.reverse[type],
        "uri": uri,
      };
}

class Album {
  Album({
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

  AlbumType? albumType;
  List<Artist>? artists;
  List<String>? availableMarkets;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Image>? images;
  String? name;
  DateTime? releaseDate;
  ReleaseDatePrecision? releaseDatePrecision;
  int? totalTracks;
  AlbumTypeEnum? type;
  String? uri;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumType: albumTypeValues.map![json["album_type"]],
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        availableMarkets:
            List<String>.from(json["available_markets"].map((x) => x)),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        name: json["name"],
        releaseDate: DateTime.parse(json["release_date"]),
        releaseDatePrecision:
            releaseDatePrecisionValues.map![json["release_date_precision"]],
        totalTracks: json["total_tracks"],
        type: albumTypeEnumValues.map![json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "album_type": albumTypeValues.reverse[albumType],
        "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
        "available_markets":
            List<dynamic>.from(availableMarkets!.map((x) => x)),
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "name": name,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "release_date_precision":
            releaseDatePrecisionValues.reverse[releaseDatePrecision],
        "total_tracks": totalTracks,
        "type": albumTypeEnumValues.reverse[type],
        "uri": uri,
      };
}

enum AlbumType { SINGLE, ALBUM }

final albumTypeValues =
    EnumValues({"ALBUM": AlbumType.ALBUM, "SINGLE": AlbumType.SINGLE});

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

enum ReleaseDatePrecision { DAY }

final releaseDatePrecisionValues =
    EnumValues({"day": ReleaseDatePrecision.DAY});

enum AlbumTypeEnum { ALBUM }

final albumTypeEnumValues = EnumValues({"album": AlbumTypeEnum.ALBUM});

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

enum ItemType { TRACK }

final itemTypeValues = EnumValues({"track": ItemType.TRACK});

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
