class Track {
  final String id,
      name,
      artistName,
      smallImageUrl,
      largeImageUrl,
      date,
      externalUrl;
  final int duration;

  Track(
      {required this.id,
      required this.name,
      required this.artistName,
      required this.smallImageUrl,
      required this.largeImageUrl,
      required this.externalUrl,
      required this.duration,
      required this.date});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        id: json['data']['id'],
        name: json['data']['name'],
        artistName: json['data']['artists']['items'][0]['profile']['name'],
        smallImageUrl: json['data']['albumOfTrack']['coverArt']['sources'][0]
            ['url'],
        largeImageUrl: json['data']['albumOfTrack']['coverArt']['sources'][2]
            ['url'],
        externalUrl: "https://open.spotify.com/track/${json['data']['id']}",
        duration: json['data']['duration']['totalMilliseconds'],
        date: "Unknown");
  }

  factory Track.fromJsonAlbumTracks(Map<String, dynamic> json) {
    return Track(
        id: json['uid'],
        name: json['track']['name'],
        artistName: json['track']['artists']['items'][0]['profile']['name'],
        // Use Album Cover Art
        smallImageUrl: "",
        largeImageUrl: "",
        externalUrl: "https://open.spotify.com/track/${json['uid']}",
        duration: json['track']['duration']['totalMilliseconds'],
        date: "Unknown");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artistName': artistName,
      'smallImageUrl': smallImageUrl,
      'largeImageUrl': largeImageUrl,
      'external_url': externalUrl,
      'duration': duration,
      'date': date,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artistName': artistName,
      'smallImageUrl': smallImageUrl,
      'largeImageUrl': largeImageUrl,
      'external_url': externalUrl,
      'duration': duration,
      'date': date,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['id'] as String,
      name: map['name'] as String,
      artistName: map['artistName'] as String,
      smallImageUrl: map['smallImageUrl'] as String,
      largeImageUrl: map['largeImageUrl'] as String,
      externalUrl: map['external_url'] as String,
      duration: map['duration'] as int,
      date: map['date'] as String,
    );
  }
}
