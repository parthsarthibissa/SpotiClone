// To parse this JSON data, do
//
//     final myTopArtists = myTopArtistsFromJson(jsonString);

import 'dart:convert';

MyTopArtists myTopArtistsFromJson(String str) =>
    MyTopArtists.fromJson(json.decode(str));

String myTopArtistsToJson(MyTopArtists data) => json.encode(data.toJson());

class MyTopArtists {
  MyTopArtists({
    this.items,
    this.total,
    this.limit,
    this.offset,
    this.previous,
    this.href,
    this.next,
  });

  List<TopArtistItem>? items;
  int? total;
  int? limit;
  int? offset;
  dynamic previous;
  String? href;
  String? next;

  factory MyTopArtists.fromJson(Map<String, dynamic> json) => MyTopArtists(
        items: List<TopArtistItem>.from(
            json["items"].map((x) => TopArtistItem.fromJson(x))),
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

class TopArtistItem {
  TopArtistItem({
    this.externalUrls,
    this.followers,
    this.genres,
    this.href,
    this.id,
    this.images,
    this.name,
    this.popularity,
    this.type,
    this.uri,
  });

  ExternalUrls? externalUrls;
  Followers? followers;
  List<String>? genres;
  String? href;
  String? id;
  List<Image>? images;
  String? name;
  int? popularity;
  Type? type;
  String? uri;

  factory TopArtistItem.fromJson(Map<String, dynamic> json) => TopArtistItem(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        followers: Followers.fromJson(json["followers"]),
        genres: List<String>.from(json["genres"].map((x) => x)),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        name: json["name"],
        popularity: json["popularity"],
        type: typeValues.map![json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "external_urls": externalUrls!.toJson(),
        "followers": followers!.toJson(),
        "genres": List<dynamic>.from(genres!.map((x) => x)),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "name": name,
        "popularity": popularity,
        "type": typeValues.reverse[type],
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

class Followers {
  Followers({
    this.href,
    this.total,
  });

  dynamic href;
  int? total;

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        href: json["href"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "total": total,
      };
}

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

enum Type { ARTIST }

final typeValues = EnumValues({"artist": Type.ARTIST});

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
