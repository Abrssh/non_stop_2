import 'package:flutter/material.dart';

class Artist {
  final String id, name, smallImageUrl, largeImageUrl;
  // final int popularity;

  Artist({
    required this.id,
    required this.name,
    required this.smallImageUrl,
    required this.largeImageUrl,
    // required this.popularity,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    try {
      String uri = json['data']['uri'];
      List<String> uriParts = uri.split(':');
      bool imageExists = false;
      try {
        if (json['data']['visuals']['avatarImage']['sources'][2]['url'] !=
            null) {
          imageExists = true;
        } else {
          imageExists = false;
        }
      } catch (e) {
        imageExists = false;
        // debugPrint("erImgEx: $e ErrorImage Exists: $imageExists");
      }
      const String defaultUrl =
          "https://images.pexels.com/photos/17573962/pexels-photo-17573962/free-photo-of-portrait-of-woman-holding-vinyl-record-to-her-face.jpeg?";

      // debugPrint("Image Exists: $imageExists");

      return Artist(
        id: uriParts.last,
        name: json['data']['profile']['name'],
        largeImageUrl: imageExists
            ? json['data']['visuals']['avatarImage']['sources'][2]['url']
            : defaultUrl,
        smallImageUrl: imageExists
            ? json['data']['visuals']['avatarImage']['sources'][1]['url']
            : defaultUrl,
        // popularity: json['popularity'],
      );
    } catch (e) {
      debugPrint("Artist.fromJson Error: $e");
      const String defaultUrl =
          "https://images.pexels.com/photos/17573962/pexels-photo-17573962/free-photo-of-portrait-of-woman-holding-vinyl-record-to-her-face.jpeg?";

      return Artist(
        id: "0",
        name: "Unknown",
        largeImageUrl: defaultUrl,
        smallImageUrl: defaultUrl,
        // popularity: 0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'images': [
        {'url': largeImageUrl},
        {'url': smallImageUrl}
      ],
      // 'popularity': popularity,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'smallImageUrl': smallImageUrl,
      'largeImageUrl': largeImageUrl,
      // 'popularity': popularity,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      id: map['id'],
      name: map['name'],
      smallImageUrl: map['smallImageUrl'],
      largeImageUrl: map['largeImageUrl'],
      // popularity: map['popularity'],
    );
  }
}
