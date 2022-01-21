// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.categories,
  });

  Categories? categories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: Categories.fromJson(json["categories"]),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories!.toJson(),
      };
}

class Categories {
  Categories({
    this.href,
    this.items,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
  });

  String? href;
  List<CategoryItem>? items;
  int? limit;
  String? next;
  int? offset;
  dynamic previous;
  int? total;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        href: json["href"],
        items: List<CategoryItem>.from(
            json["items"].map((x) => CategoryItem.fromJson(x))),
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

class CategoryItem {
  CategoryItem({
    this.href,
    this.icons,
    this.id,
    this.name,
  });

  String? href;
  List<CategoryIcon>? icons;
  String? id;
  String? name;

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        href: json["href"],
        icons: List<CategoryIcon>.from(
            json["icons"].map((x) => CategoryIcon.fromJson(x))),
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "icons": List<dynamic>.from(icons!.map((x) => x.toJson())),
        "id": id,
        "name": name,
      };
}

class CategoryIcon {
  CategoryIcon({
    this.height,
    this.url,
    this.width,
  });

  int? height;
  String? url;
  int? width;

  factory CategoryIcon.fromJson(Map<String, dynamic> json) => CategoryIcon(
        height: json["height"] == null ? null : json["height"],
        url: json["url"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "url": url,
        "width": width == null ? null : width,
      };
}
