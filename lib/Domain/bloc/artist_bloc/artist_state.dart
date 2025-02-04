part of 'artist_bloc.dart';

final class ArtistState extends Equatable {
  final List<Artist> artists;
  final bool isIntial;
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  const ArtistState(
      {this.artists = const [],
      this.isLoading = false,
      this.isError = false,
      this.isIntial = true,
      this.errorMessage = ''});

  ArtistState copyWith({
    List<Artist>? artists,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? isIntial,
  }) {
    return ArtistState(
      artists: artists ?? this.artists,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isIntial: isIntial ?? this.isIntial,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artists': artists.map((artist) => artist.toMap()).toList(),
      'isLoading': isLoading,
      'isError': isError,
      'errorMessage': errorMessage,
      'isIntial': isIntial,
    };
  }

  factory ArtistState.fromJson(Map<String, dynamic> map) {
    return ArtistState(
      artists: List<Artist>.from(
          map['artists']?.map((x) => Artist.fromMap(x)) ?? []),
      isLoading: map['isLoading'] ?? false,
      isError: map['isError'] ?? false,
      errorMessage: map['errorMessage'] ?? '',
      isIntial: map['isIntial'] ?? true,
    );
  }

  @override
  List<Object> get props =>
      [artists, isLoading, isError, errorMessage, isIntial];
}
