// To parse this JSON data, do
//
//     final spotifyModel = spotifyModelFromJson(jsonString);

import 'dart:convert';

SpotifyModel spotifyModelFromJson(String str) => SpotifyModel.fromJson(json.decode(str));

String spotifyModelToJson(SpotifyModel data) => json.encode(data.toJson());

class SpotifyModel {
  SpotifyModel({
    this.tracks,
  });

  final Tracks tracks;

  SpotifyModel copyWith({
    Tracks tracks,
  }) =>
      SpotifyModel(
        tracks: tracks ?? this.tracks,
      );

  factory SpotifyModel.fromJson(Map<String, dynamic> json) => SpotifyModel(
    tracks: Tracks.fromJson(json["tracks"]),
  );

  Map<String, dynamic> toJson() => {
    "tracks": tracks.toJson(),
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

  final String href;
  final List<Item> items;
  final int limit;
  final String next;
  final int offset;
  final dynamic previous;
  final int total;

  Tracks copyWith({
    String href,
    List<Item> items,
    int limit,
    String next,
    int offset,
    dynamic previous,
    int total,
  }) =>
      Tracks(
        href: href ?? this.href,
        items: items ?? this.items,
        limit: limit ?? this.limit,
        next: next ?? this.next,
        offset: offset ?? this.offset,
        previous: previous ?? this.previous,
        total: total ?? this.total,
      );

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
    href: json["href"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    limit: json["limit"],
    next: json["next"],
    offset: json["offset"],
    previous: json["previous"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "limit": limit,
    "next": next,
    "offset": offset,
    "previous": previous,
    "total": total,
  };
}

class Item {
  Item({
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

  final Album album;
  final List<Artist> artists;
  final List<String> availableMarkets;
  final int discNumber;
  final int durationMs;
  final bool explicit;
  final ExternalIds externalIds;
  final ExternalUrls externalUrls;
  final String href;
  final String id;
  final bool isLocal;
  final String name;
  final int popularity;
  final String previewUrl;
  final int trackNumber;
  final String type;
  final String uri;

  Item copyWith({
    Album album,
    List<Artist> artists,
    List<String> availableMarkets,
    int discNumber,
    int durationMs,
    bool explicit,
    ExternalIds externalIds,
    ExternalUrls externalUrls,
    String href,
    String id,
    bool isLocal,
    String name,
    int popularity,
    String previewUrl,
    int trackNumber,
    String type,
    String uri,
  }) =>
      Item(
        album: album ?? this.album,
        artists: artists ?? this.artists,
        availableMarkets: availableMarkets ?? this.availableMarkets,
        discNumber: discNumber ?? this.discNumber,
        durationMs: durationMs ?? this.durationMs,
        explicit: explicit ?? this.explicit,
        externalIds: externalIds ?? this.externalIds,
        externalUrls: externalUrls ?? this.externalUrls,
        href: href ?? this.href,
        id: id ?? this.id,
        isLocal: isLocal ?? this.isLocal,
        name: name ?? this.name,
        popularity: popularity ?? this.popularity,
        previewUrl: previewUrl ?? this.previewUrl,
        trackNumber: trackNumber ?? this.trackNumber,
        type: type ?? this.type,
        uri: uri ?? this.uri,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    album: Album.fromJson(json["album"]),
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    availableMarkets: List<String>.from(json["available_markets"].map((x) => x)),
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
    type: json["type"],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "album": album.toJson(),
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "available_markets": List<dynamic>.from(availableMarkets.map((x) => x)),
    "disc_number": discNumber,
    "duration_ms": durationMs,
    "explicit": explicit,
    "external_ids": externalIds.toJson(),
    "external_urls": externalUrls.toJson(),
    "href": href,
    "id": id,
    "is_local": isLocal,
    "name": name,
    "popularity": popularity,
    "preview_url": previewUrl,
    "track_number": trackNumber,
    "type": type,
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

  final String albumType;
  final List<Artist> artists;
  final List<String> availableMarkets;
  final ExternalUrls externalUrls;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final DateTime releaseDate;
  final String releaseDatePrecision;
  final int totalTracks;
  final String type;
  final String uri;

  Album copyWith({
    String albumType,
    List<Artist> artists,
    List<String> availableMarkets,
    ExternalUrls externalUrls,
    String href,
    String id,
    List<Image> images,
    String name,
    DateTime releaseDate,
    String releaseDatePrecision,
    int totalTracks,
    String type,
    String uri,
  }) =>
      Album(
        albumType: albumType ?? this.albumType,
        artists: artists ?? this.artists,
        availableMarkets: availableMarkets ?? this.availableMarkets,
        externalUrls: externalUrls ?? this.externalUrls,
        href: href ?? this.href,
        id: id ?? this.id,
        images: images ?? this.images,
        name: name ?? this.name,
        releaseDate: releaseDate ?? this.releaseDate,
        releaseDatePrecision: releaseDatePrecision ?? this.releaseDatePrecision,
        totalTracks: totalTracks ?? this.totalTracks,
        type: type ?? this.type,
        uri: uri ?? this.uri,
      );

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    albumType: json["album_type"],
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    availableMarkets: List<String>.from(json["available_markets"].map((x) => x)),
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    name: json["name"],
    releaseDate: DateTime.parse(json["release_date"]),
    releaseDatePrecision: json["release_date_precision"],
    totalTracks: json["total_tracks"],
    type: json["type"],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "album_type": albumType,
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "available_markets": List<dynamic>.from(availableMarkets.map((x) => x)),
    "external_urls": externalUrls.toJson(),
    "href": href,
    "id": id,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "name": name,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "release_date_precision": releaseDatePrecision,
    "total_tracks": totalTracks,
    "type": type,
    "uri": uri,
  };
}

class Artist {
  Artist({
    this.externalUrls,
    this.href,
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  final ExternalUrls externalUrls;
  final String href;
  final String id;
  final String name;
  final String type;
  final String uri;

  Artist copyWith({
    ExternalUrls externalUrls,
    String href,
    String id,
    String name,
    String type,
    String uri,
  }) =>
      Artist(
        externalUrls: externalUrls ?? this.externalUrls,
        href: href ?? this.href,
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        uri: uri ?? this.uri,
      );

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    name: json["name"],
    type: json["type"],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls.toJson(),
    "href": href,
    "id": id,
    "name": name,
    "type": type,
    "uri": uri,
  };
}

class ExternalUrls {
  ExternalUrls({
    this.spotify,
  });

  final String spotify;

  ExternalUrls copyWith({
    String spotify,
  }) =>
      ExternalUrls(
        spotify: spotify ?? this.spotify,
      );

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
    spotify: json["spotify"],
  );

  Map<String, dynamic> toJson() => {
    "spotify": spotify,
  };
}

class Image {
  Image({
    this.height,
    this.url,
    this.width,
  });

  final int height;
  final String url;
  final int width;

  Image copyWith({
    int height,
    String url,
    int width,
  }) =>
      Image(
        height: height ?? this.height,
        url: url ?? this.url,
        width: width ?? this.width,
      );

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

class ExternalIds {
  ExternalIds({
    this.isrc,
  });

  final String isrc;

  ExternalIds copyWith({
    String isrc,
  }) =>
      ExternalIds(
        isrc: isrc ?? this.isrc,
      );

  factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
    isrc: json["isrc"],
  );

  Map<String, dynamic> toJson() => {
    "isrc": isrc,
  };
}
