// To parse this JSON data, do
//
//     final sourcesResponse = sourcesResponseFromJson(jsonString);

import 'dart:convert';

SourcesResponse sourcesResponseFromJson(String str) => SourcesResponse.fromJson(json.decode(str));

String sourcesResponseToJson(SourcesResponse data) => json.encode(data.toJson());

class SourcesResponse {
  SourcesResponse({
    this.status,
    this.sources,
  });

  String status;
  List<Source> sources;

  factory SourcesResponse.fromJson(Map<String, dynamic> json) => SourcesResponse(
    status: json["status"],
    sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
  };
}

class Source {
  Source({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
    this.isChecked,
  });

  String id;
  String name;
  String description;
  String url;
  Category category;
  String language;
  String country;
  bool isChecked;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    url: json["url"],
    category: categoryValues.map[json["category"]],
    language: json["language"],
    country: json["country"],
    isChecked: json["isChecked"]=false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "url": url,
    "category": categoryValues.reverse[category],
    "language": language,
    "country": country,
    "isChecked": isChecked,
  };
}

enum Category { GENERAL, BUSINESS, TECHNOLOGY, SPORTS, ENTERTAINMENT, HEALTH, SCIENCE }

final categoryValues = EnumValues({
  "business": Category.BUSINESS,
  "entertainment": Category.ENTERTAINMENT,
  "general": Category.GENERAL,
  "health": Category.HEALTH,
  "science": Category.SCIENCE,
  "sports": Category.SPORTS,
  "technology": Category.TECHNOLOGY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
