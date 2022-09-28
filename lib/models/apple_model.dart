// To parse this JSON data, do
//
//     final appleModel = appleModelFromJson(jsonString);

import 'dart:convert';

AppleModel appleModelFromJson(String str) => AppleModel.fromJson(json.decode(str));

String appleModelToJson(AppleModel data) => json.encode(data.toJson());

class AppleModel {
  AppleModel({
    this.results,
    this.meta,
  });

  final AppleModelResults results;
  final Meta meta;

  AppleModel copyWith({
    AppleModelResults results,
    Meta meta,
  }) =>
      AppleModel(
        results: results ?? this.results,
        meta: meta ?? this.meta,
      );

  factory AppleModel.fromJson(Map<String, dynamic> json) => AppleModel(
    results: AppleModelResults.fromJson(json["results"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "meta": meta.toJson(),
  };
}

class Meta {
  Meta({
    this.results,
  });

  final MetaResults results;

  Meta copyWith({
    MetaResults results,
  }) =>
      Meta(
        results: results ?? this.results,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    results: MetaResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
  };
}

class MetaResults {
  MetaResults({
    this.order,
    this.rawOrder,
  });

  final List<String> order;
  final List<String> rawOrder;

  MetaResults copyWith({
    List<String> order,
    List<String> rawOrder,
  }) =>
      MetaResults(
        order: order ?? this.order,
        rawOrder: rawOrder ?? this.rawOrder,
      );

  factory MetaResults.fromJson(Map<String, dynamic> json) => MetaResults(
    order: List<String>.from(json["order"].map((x) => x)),
    rawOrder: List<String>.from(json["rawOrder"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "order": List<dynamic>.from(order.map((x) => x)),
    "rawOrder": List<dynamic>.from(rawOrder.map((x) => x)),
  };
}

class AppleModelResults {
  AppleModelResults({
    this.songs,
  });

  final Songs songs;

  AppleModelResults copyWith({
    Songs songs,
  }) =>
      AppleModelResults(
        songs: songs ?? this.songs,
      );

  factory AppleModelResults.fromJson(Map<String, dynamic> json) => AppleModelResults(
    songs: Songs.fromJson(json["songs"]),
  );

  Map<String, dynamic> toJson() => {
    "songs": songs.toJson(),
  };
}

class Songs {
  Songs({
    this.href,
    this.next,
    this.data,
  });

  final String href;
  final String next;
  final List<Datum> data;

  Songs copyWith({
    String href,
    String next,
    List<Datum> data,
  }) =>
      Songs(
        href: href ?? this.href,
        next: next ?? this.next,
        data: data ?? this.data,
      );

  factory Songs.fromJson(Map<String, dynamic> json) => Songs(
    href: json["href"],
    next: json["next"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "next": next,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.type,
    this.href,
    this.attributes,
  });

  final String id;
  final String type;
  final String href;
  final Attributes attributes;

  Datum copyWith({
    String id,
    String type,
    String href,
    Attributes attributes,
  }) =>
      Datum(
        id: id ?? this.id,
        type: type ?? this.type,
        href: href ?? this.href,
        attributes: attributes ?? this.attributes,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    href: json["href"],
    attributes: Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "href": href,
    "attributes": attributes.toJson(),
  };
}

class Attributes {
  Attributes({
    this.albumName,
    this.genreNames,
    this.trackNumber,
    this.releaseDate,
    this.durationInMillis,
    this.isrc,
    this.artwork,
    this.composerName,
    this.url,
    this.playParams,
    this.discNumber,
    this.hasLyrics,
    this.isAppleDigitalMaster,
    this.name,
    this.previews,
    this.artistName,
  });

  final String albumName;
  final List<String> genreNames;
  final int trackNumber;
  final DateTime releaseDate;
  final int durationInMillis;
  final String isrc;
  final Artwork artwork;
  final String composerName;
  final String url;
  final PlayParams playParams;
  final int discNumber;
  final bool hasLyrics;
  final bool isAppleDigitalMaster;
  final String name;
  final List<Preview> previews;
  final String artistName;

  Attributes copyWith({
    String albumName,
    List<String> genreNames,
    int trackNumber,
    DateTime releaseDate,
    int durationInMillis,
    String isrc,
    Artwork artwork,
    String composerName,
    String url,
    PlayParams playParams,
    int discNumber,
    bool hasLyrics,
    bool isAppleDigitalMaster,
    String name,
    List<Preview> previews,
    String artistName,
  }) =>
      Attributes(
        albumName: albumName ?? this.albumName,
        genreNames: genreNames ?? this.genreNames,
        trackNumber: trackNumber ?? this.trackNumber,
        releaseDate: releaseDate ?? this.releaseDate,
        durationInMillis: durationInMillis ?? this.durationInMillis,
        isrc: isrc ?? this.isrc,
        artwork: artwork ?? this.artwork,
        composerName: composerName ?? this.composerName,
        url: url ?? this.url,
        playParams: playParams ?? this.playParams,
        discNumber: discNumber ?? this.discNumber,
        hasLyrics: hasLyrics ?? this.hasLyrics,
        isAppleDigitalMaster: isAppleDigitalMaster ?? this.isAppleDigitalMaster,
        name: name ?? this.name,
        previews: previews ?? this.previews,
        artistName: artistName ?? this.artistName,
      );

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    albumName: json["albumName"],
    genreNames: List<String>.from(json["genreNames"].map((x) => x)),
    trackNumber: json["trackNumber"],
    releaseDate: DateTime.parse(json["releaseDate"]),
    durationInMillis: json["durationInMillis"],
    isrc: json["isrc"],
    artwork: Artwork.fromJson(json["artwork"]),
    composerName: json["composerName"],
    url: json["url"],
    playParams: PlayParams.fromJson(json["playParams"]),
    discNumber: json["discNumber"],
    hasLyrics: json["hasLyrics"],
    isAppleDigitalMaster: json["isAppleDigitalMaster"],
    name: json["name"],
    previews: List<Preview>.from(json["previews"].map((x) => Preview.fromJson(x))),
    artistName: json["artistName"],
  );

  Map<String, dynamic> toJson() => {
    "albumName": albumName,
    "genreNames": List<dynamic>.from(genreNames.map((x) => x)),
    "trackNumber": trackNumber,
    "releaseDate": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "durationInMillis": durationInMillis,
    "isrc": isrc,
    "artwork": artwork.toJson(),
    "composerName": composerName,
    "url": url,
    "playParams": playParams.toJson(),
    "discNumber": discNumber,
    "hasLyrics": hasLyrics,
    "isAppleDigitalMaster": isAppleDigitalMaster,
    "name": name,
    "previews": List<dynamic>.from(previews.map((x) => x.toJson())),
    "artistName": artistName,
  };
}

class Artwork {
  Artwork({
    this.width,
    this.height,
    this.url,
    this.bgColor,
    this.textColor1,
    this.textColor2,
    this.textColor3,
    this.textColor4,
  });

  final int width;
  final int height;
  final String url;
  final String bgColor;
  final String textColor1;
  final String textColor2;
  final String textColor3;
  final String textColor4;

  Artwork copyWith({
    int width,
    int height,
    String url,
    String bgColor,
    String textColor1,
    String textColor2,
    String textColor3,
    String textColor4,
  }) =>
      Artwork(
        width: width ?? this.width,
        height: height ?? this.height,
        url: url ?? this.url,
        bgColor: bgColor ?? this.bgColor,
        textColor1: textColor1 ?? this.textColor1,
        textColor2: textColor2 ?? this.textColor2,
        textColor3: textColor3 ?? this.textColor3,
        textColor4: textColor4 ?? this.textColor4,
      );

  factory Artwork.fromJson(Map<String, dynamic> json) => Artwork(
    width: json["width"],
    height: json["height"],
    url: json["url"],
    bgColor: json["bgColor"],
    textColor1: json["textColor1"],
    textColor2: json["textColor2"],
    textColor3: json["textColor3"],
    textColor4: json["textColor4"],
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "url": url,
    "bgColor": bgColor,
    "textColor1": textColor1,
    "textColor2": textColor2,
    "textColor3": textColor3,
    "textColor4": textColor4,
  };
}

class PlayParams {
  PlayParams({
    this.id,
    this.kind,
  });

  final String id;
  final String kind;

  PlayParams copyWith({
    String id,
    String kind,
  }) =>
      PlayParams(
        id: id ?? this.id,
        kind: kind ?? this.kind,
      );

  factory PlayParams.fromJson(Map<String, dynamic> json) => PlayParams(
    id: json["id"],
    kind: json["kind"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kind": kind,
  };
}

class Preview {
  Preview({
    this.url,
  });

  final String url;

  Preview copyWith({
    String url,
  }) =>
      Preview(
        url: url ?? this.url,
      );

  factory Preview.fromJson(Map<String, dynamic> json) => Preview(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}
