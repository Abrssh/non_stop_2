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
}
