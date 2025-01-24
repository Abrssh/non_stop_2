class Track {
  final String id, name, artistName, smallImageUrl, largeImageUrl, date;
  final double duration;

  Track(
      {required this.id,
      required this.name,
      required this.artistName,
      required this.smallImageUrl,
      required this.largeImageUrl,
      required this.duration,
      required this.date});
}
