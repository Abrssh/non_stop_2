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
    String uri = json['data']['uri'];
    List<String> uriParts = uri.split(':');
    return Artist(
        id: uriParts.last,
        name: json['data']['profile']['name'],
        largeImageUrl: json['data']['visuals']['sources'][2],
        smallImageUrl: json['data']['visuals']['sources'][1]
        // popularity: json['popularity'],
        );
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
}
