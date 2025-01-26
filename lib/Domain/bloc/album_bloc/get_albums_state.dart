part of 'get_albums_bloc.dart';

class GetAlbumsState extends Equatable {
  final List<Album> albumsList;
  final bool isLoading;
  final String errorMessage;
  const GetAlbumsState({
    this.albumsList = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  GetAlbumsState copyWith({
    List<Album>? albumsList,
    bool? isLoading,
    String? errorMessage,
  }) {
    return GetAlbumsState(
      albumsList: albumsList ?? this.albumsList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [albumsList, isLoading, errorMessage];
}
