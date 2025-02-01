import 'package:flutter/material.dart';

class Album {
  final String id, name, artist, smallImageUrl, largeImageUrl, spotifyUrl, date;

  Album({
    required this.id,
    required this.name,
    required this.artist,
    required this.smallImageUrl,
    required this.largeImageUrl,
    required this.spotifyUrl,
    required this.date,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    debugPrint("Album Json: $json");
    String uri = json['data']['uri'];
    List<String> uriParts = uri.split(':');
    return Album(
      id: uriParts.last,
      name: json['data']['name'],
      artist: json['data']['artists']['items'][0]['profile']['name'],
      largeImageUrl: json['data']['coverArt']['sources'][0]['url'],
      smallImageUrl: json['data']['coverArt']['sources'][1]['url'],
      spotifyUrl: "https://open.spotify.com/album/${uriParts.last}",
      date: json['data']['date']['year'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'artist': artist,
        'smallImageUrl': smallImageUrl,
        'largeImageUrl': largeImageUrl,
        'spotifyUrl': spotifyUrl,
        'date': date,
      };
}
