// To parse this JSON data, do
//
//     final movieListResponse = movieListResponseFromJson(jsonString);

import 'dart:convert';

MovieListResponse movieListResponseFromJson(String str) =>
    MovieListResponse.fromJson(json.decode(str));

String movieListResponseToJson(MovieListResponse data) =>
    json.encode(data.toJson());

class MovieListResponse {
  List<MovieResult> result;
  QueryParam queryParam;
  int code;
  String message;

  MovieListResponse({
    required this.result,
    required this.queryParam,
    required this.code,
    required this.message,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      MovieListResponse(
        result: List<MovieResult>.from(
            json["result"].map((x) => MovieResult.fromJson(x))),
        queryParam: QueryParam.fromJson(json["queryParam"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "queryParam": queryParam.toJson(),
        "code": code,
        "message": message,
      };
}

class QueryParam {
  String category;
  String language;
  String genre;
  String sort;

  QueryParam({
    required this.category,
    required this.language,
    required this.genre,
    required this.sort,
  });

  factory QueryParam.fromJson(Map<String, dynamic> json) => QueryParam(
        category: json["category"],
        language: json["language"],
        genre: json["genre"],
        sort: json["sort"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "language": language,
        "genre": genre,
        "sort": sort,
      };
}

class MovieResult {
  String id;
  List<String> director;
  List<String> writers;
  List<String> stars;
  int releasedDate;
  List<String> productionCompany;
  String title;
  String language;
  int? runTime;
  String genre;
  List<Voted> voted;
  String poster;
  int pageViews;
  String description;
  List<String>? upVoted;
  List<String>? downVoted;
  int totalVoted;
  int voting;

  MovieResult({
    required this.id,
    required this.director,
    required this.writers,
    required this.stars,
    required this.releasedDate,
    required this.productionCompany,
    required this.title,
    required this.language,
    required this.runTime,
    required this.genre,
    required this.voted,
    required this.poster,
    required this.pageViews,
    required this.description,
    this.upVoted,
    this.downVoted,
    required this.totalVoted,
    required this.voting,
  });

  factory MovieResult.fromJson(Map<String, dynamic> json) => MovieResult(
        id: json["_id"],
        director: List<String>.from(json["director"].map((x) => x)),
        writers: List<String>.from(json["writers"].map((x) => x)),
        stars: List<String>.from(json["stars"].map((x) => x)),
        releasedDate: json["releasedDate"],
        productionCompany:
            List<String>.from(json["productionCompany"].map((x) => x)),
        title: json["title"],
        language: json["language"] ?? "",
        runTime: json["runTime"],
        genre: json["genre"],
        voted: List<Voted>.from(json["voted"].map((x) => Voted.fromJson(x))),
        poster: json["poster"],
        pageViews: json["pageViews"],
        description: json["description"],
        upVoted: json["upVoted"] == null
            ? []
            : List<String>.from(json["upVoted"]!.map((x) => x)),
        downVoted: json["downVoted"] == null
            ? []
            : List<String>.from(json["downVoted"]!.map((x) => x)),
        totalVoted: json["totalVoted"],
        voting: json["voting"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "director": List<dynamic>.from(director.map((x) => x)),
        "writers": List<dynamic>.from(writers.map((x) => x)),
        "stars": List<dynamic>.from(stars.map((x) => x)),
        "releasedDate": releasedDate,
        "productionCompany":
            List<dynamic>.from(productionCompany.map((x) => x)),
        "title": title,
        "runTime": runTime,
        "genre": genre,
        "voted": List<dynamic>.from(voted.map((x) => x.toJson())),
        "poster": poster,
        "pageViews": pageViews,
        "description": description,
        "upVoted":
            upVoted == null ? [] : List<dynamic>.from(upVoted!.map((x) => x)),
        "downVoted": downVoted == null
            ? []
            : List<dynamic>.from(downVoted!.map((x) => x)),
        "totalVoted": totalVoted,
        "voting": voting,
      };
}

class Voted {
  List<String> upVoted;
  List<dynamic> downVoted;
  String id;
  int updatedAt;
  String genre;

  Voted({
    required this.upVoted,
    required this.downVoted,
    required this.id,
    required this.updatedAt,
    required this.genre,
  });

  factory Voted.fromJson(Map<String, dynamic> json) => Voted(
        upVoted: List<String>.from(json["upVoted"].map((x) => x)),
        downVoted: List<dynamic>.from(json["downVoted"].map((x) => x)),
        id: json["_id"],
        updatedAt: json["updatedAt"],
        genre: json["genre"],
      );

  Map<String, dynamic> toJson() => {
        "upVoted": List<dynamic>.from(upVoted.map((x) => x)),
        "downVoted": List<dynamic>.from(downVoted.map((x) => x)),
        "_id": id,
        "updatedAt": updatedAt,
        "genre": genre,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
