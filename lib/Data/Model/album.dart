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
    // debugPrint("Album Json: $json");
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

  factory Album.fromJsonArtistAlbums(Map<String, dynamic> json2) {
    // debugPrint("From Artist Albums: $json2");
    Map<String, dynamic> json = json2['releases']['items'][0];
    return Album(
      id: json['id'],
      name: json['name'],
      artist: "",
      largeImageUrl: json['coverArt']['sources'][2]['url'],
      smallImageUrl: json['coverArt']['sources'][0]['url'],
      spotifyUrl: "https://open.spotify.com/album/${json['id']}",
      date: json['date']['year'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'smallImageUrl': smallImageUrl,
      'largeImageUrl': largeImageUrl,
      'spotifyUrl': spotifyUrl,
      'date': date,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'smallImageUrl': smallImageUrl,
      'largeImageUrl': largeImageUrl,
      'spotifyUrl': spotifyUrl,
      'date': date,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
        id: map['id'],
        name: map['name'],
        artist: map['artist'],
        smallImageUrl: map['smallImageUrl'],
        largeImageUrl: map['largeImageUrl'],
        spotifyUrl: map['spotifyUrl'],
        date: map['date']);
  }
}
