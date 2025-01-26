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
    return Album(
      id: json['id'],
      name: json['name'],
      artist: json['artists'][0]['name'],
      smallImageUrl: json['images'][0]['url'],
      largeImageUrl: json['images'][1]['url'],
      spotifyUrl: json['external_urls']['spotify'],
      date: json['release_date'],
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
