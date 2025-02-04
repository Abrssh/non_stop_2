part of 'get_albums_bloc.dart';

class GetAlbumsState extends Equatable {
  final List<Album> albumsList;
  final List<Album> artistAlbums;
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  const GetAlbumsState({
    this.albumsList = const [],
    this.artistAlbums = const [],
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
  });

  GetAlbumsState copyWith({
    List<Album>? albumsList,
    List<Album>? artistAlbums,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return GetAlbumsState(
      albumsList: albumsList ?? this.albumsList,
      artistAlbums: artistAlbums ?? this.artistAlbums,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isError: isError ?? this.isError,
    );
  }

  factory GetAlbumsState.fromJson(Map<String, dynamic> json) {
    return GetAlbumsState(
      albumsList: (json['albumsList'] as List<dynamic>?)
              ?.map((e) => Album.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      artistAlbums: (json['artistAlbums'] as List<dynamic>?)
              ?.map((e) => Album.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      isLoading: json['isLoading'] as bool? ?? false,
      isError: json['isError'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'albumsList': albumsList.map((e) => e.toMap()).toList(),
        'artistAlbums': artistAlbums.map((e) => e.toMap()).toList(),
        'isLoading': isLoading,
        'isError': isError,
        'errorMessage': errorMessage,
      };

  @override
  List<Object> get props =>
      [albumsList, artistAlbums, isLoading, errorMessage, isError];
}
